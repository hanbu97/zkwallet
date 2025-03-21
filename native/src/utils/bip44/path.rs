use super::Bip44;
use {
    core::{iter::IntoIterator, slice::Iter},
    derivation_path::{ChildIndex, DerivationPath as DerivationPathInner},
    std::{convert::Infallible, fmt, str::FromStr},
    thiserror::Error,
    uriparse::URIReference,
};

const ACCOUNT_INDEX: usize = 2;
const CHANGE_INDEX: usize = 3;

/// Derivation path error.
#[derive(Error, Debug, Clone, PartialEq, Eq)]
pub enum DerivationPathError {
    #[error("invalid derivation path: {0}")]
    InvalidDerivationPath(String),
    #[error("infallible")]
    Infallible,
}

impl From<Infallible> for DerivationPathError {
    fn from(_: Infallible) -> Self {
        Self::Infallible
    }
}

#[derive(Clone, PartialEq, Eq)]
pub struct DerivationPath(DerivationPathInner);

impl AsRef<[ChildIndex]> for DerivationPath {
    fn as_ref(&self) -> &[ChildIndex] {
        self.0.as_ref()
    }
}

impl DerivationPath {
    fn new<P: Into<Box<[ChildIndex]>>>(path: P) -> Self {
        Self(DerivationPathInner::new(path))
    }

    pub fn from_key_str_with_coin<T: Bip44>(
        path: &str,
        coin: T,
    ) -> Result<Self, DerivationPathError> {
        let master_path = if path == "m" {
            path.to_string()
        } else {
            format!("m/{path}")
        };
        let extend = DerivationPathInner::from_str(&master_path)
            .map_err(|err| DerivationPathError::InvalidDerivationPath(err.to_string()))?;
        let mut extend = extend.into_iter();
        let account = extend.next().map(|index| index.to_u32());
        let change = extend.next().map(|index| index.to_u32());
        if extend.next().is_some() {
            return Err(DerivationPathError::InvalidDerivationPath(format!(
                "key path `{path}` too deep, only <account>/<change> supported"
            )));
        }
        Ok(Self::new_bip44_with_coin(coin, account, change))
    }

    pub fn from_absolute_path_str(path: &str) -> Result<Self, DerivationPathError> {
        let inner = DerivationPath::_from_absolute_path_insecure_str(path)?
            .into_iter()
            .map(|c| ChildIndex::Hardened(c.to_u32()))
            .collect::<Vec<_>>();
        Ok(Self(DerivationPathInner::new(inner)))
    }

    fn _from_absolute_path_insecure_str(path: &str) -> Result<Self, DerivationPathError> {
        Ok(Self(DerivationPathInner::from_str(path).map_err(
            |err| DerivationPathError::InvalidDerivationPath(err.to_string()),
        )?))
    }

    pub fn new_bip44_with_coin<T: Bip44>(
        coin: T,
        account: Option<u32>,
        change: Option<u32>,
    ) -> Self {
        let mut indexes = coin.base_indexes();
        if let Some(account) = account {
            indexes.push(ChildIndex::Hardened(account));
            if let Some(change) = change {
                indexes.push(ChildIndex::Hardened(change));
            }
        }
        Self::new(indexes)
    }

    pub fn account(&self) -> Option<&ChildIndex> {
        self.0.path().get(ACCOUNT_INDEX)
    }

    pub fn change(&self) -> Option<&ChildIndex> {
        self.0.path().get(CHANGE_INDEX)
    }

    pub fn path(&self) -> &[ChildIndex] {
        self.0.path()
    }

    // Assumes `key` query-string key
    pub fn get_query(&self) -> String {
        if let Some(account) = &self.account() {
            if let Some(change) = &self.change() {
                format!("?key={account}/{change}")
            } else {
                format!("?key={account}")
            }
        } else {
            "".to_string()
        }
    }

    pub fn from_uri_key_query<T: Bip44>(
        uri: &URIReference<'_>,
        coin: T,
    ) -> Result<Option<Self>, DerivationPathError> {
        Self::from_uri(uri, true, coin)
    }

    pub fn from_uri_any_query<T: Bip44>(
        uri: &URIReference<'_>,
        coin: T,
    ) -> Result<Option<Self>, DerivationPathError> {
        Self::from_uri(uri, false, coin)
    }

    fn from_uri<T: Bip44>(
        uri: &URIReference<'_>,
        key_only: bool,
        coin: T,
    ) -> Result<Option<Self>, DerivationPathError> {
        if let Some(query) = uri.query() {
            let query_str = query.as_str();
            if query_str.is_empty() {
                return Ok(None);
            }
            let query = qstring::QString::from(query_str);
            if query.len() > 1 {
                return Err(DerivationPathError::InvalidDerivationPath(
                    "invalid query string, extra fields not supported".to_string(),
                ));
            }
            let key = query.get(QueryKey::Key.as_ref());
            if let Some(key) = key {
                // Use from_key_str instead of TryInto here to make it more explicit that this
                // generates a Solana bip44 DerivationPath
                return Self::from_key_str_with_coin(key, coin).map(Some);
            }
            if key_only {
                return Err(DerivationPathError::InvalidDerivationPath(format!(
                    "invalid query string `{query_str}`, only `key` supported",
                )));
            }
            let full_path = query.get(QueryKey::FullPath.as_ref());
            if let Some(full_path) = full_path {
                return Self::from_absolute_path_str(full_path).map(Some);
            }
            Err(DerivationPathError::InvalidDerivationPath(format!(
                "invalid query string `{query_str}`, only `key` and `full-path` supported",
            )))
        } else {
            Ok(None)
        }
    }
}

impl fmt::Debug for DerivationPath {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "m")?;
        for index in self.0.path() {
            write!(f, "/{index}")?;
        }
        Ok(())
    }
}

impl<'a> IntoIterator for &'a DerivationPath {
    type IntoIter = Iter<'a, ChildIndex>;
    type Item = &'a ChildIndex;
    fn into_iter(self) -> Self::IntoIter {
        self.0.into_iter()
    }
}

const QUERY_KEY_FULL_PATH: &str = "full-path";
const QUERY_KEY_KEY: &str = "key";

#[derive(Clone, Debug, Error, PartialEq, Eq)]
#[error("invalid query key `{0}`")]
struct QueryKeyError(String);

enum QueryKey {
    FullPath,
    Key,
}

impl FromStr for QueryKey {
    type Err = QueryKeyError;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let lowercase = s.to_ascii_lowercase();
        match lowercase.as_str() {
            QUERY_KEY_FULL_PATH => Ok(Self::FullPath),
            QUERY_KEY_KEY => Ok(Self::Key),
            _ => Err(QueryKeyError(s.to_string())),
        }
    }
}

impl AsRef<str> for QueryKey {
    fn as_ref(&self) -> &str {
        match self {
            Self::FullPath => QUERY_KEY_FULL_PATH,
            Self::Key => QUERY_KEY_KEY,
        }
    }
}

impl std::fmt::Display for QueryKey {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        let s: &str = self.as_ref();
        write!(f, "{s}")
    }
}
