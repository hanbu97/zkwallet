#[derive(serde::Serialize, serde::Deserialize, Clone, Default)]
pub struct WalletCreationConfig {
    pub use_mnemonic: Option<bool>,
    pub lang: Option<String>,
    pub length: Option<u8>,
    pub method: Option<String>,
    pub coin_type: Option<u32>,
    pub account_index: Option<u32>,
    pub change: Option<u32>,
    pub address_index: Option<u32>,
    pub password: Option<String>,
    // 在这里添加其他配置选项（如果有的话）
}

// WalletCreationConfig from json
impl WalletCreationConfig {
    pub fn from_json(json: &str) -> Result<Self, &str> {
        let config: WalletCreationConfig =
            serde_json::from_str(json).map_err(|_| "invalid json")?;
        Ok(config)
    }
}

pub struct CreationConfig {
    pub use_mnemonic: bool,
    pub lang: bip39::Language,
    pub length: bip39::MnemonicType,
    pub method: wallet_creation::GenMethod,
    pub coin_type: u32,
    pub account_index: u32,
    pub change: u32,
    pub address_index: u32,
    pub password: String,
    // 在这里添加其他配置选项（如果有的话）
}

impl From<WalletCreationConfig> for CreationConfig {
    fn from(config: WalletCreationConfig) -> Self {
        Self {
            use_mnemonic: config.use_mnemonic.unwrap_or(true),
            lang: match config.lang {
                Some(l) => match l.as_str().to_lowercase().as_str() {
                    "english" => bip39::Language::English,
                    "chinese_simplified" => bip39::Language::ChineseSimplified,
                    "chinese_traditional" => bip39::Language::ChineseTraditional,
                    "french" => bip39::Language::French,
                    "italian" => bip39::Language::Italian,
                    "japanese" => bip39::Language::Japanese,
                    "korean" => bip39::Language::Korean,
                    "spanish" => bip39::Language::Spanish,
                    _ => bip39::Language::English,
                },
                None => bip39::Language::English,
            },
            length: match config.length {
                Some(l) => match l {
                    12 => bip39::MnemonicType::Words12,
                    15 => bip39::MnemonicType::Words15,
                    18 => bip39::MnemonicType::Words18,
                    21 => bip39::MnemonicType::Words21,
                    24 => bip39::MnemonicType::Words24,
                    _ => bip39::MnemonicType::Words12,
                },
                None => bip39::MnemonicType::Words12,
            },
            method: match config.method {
                Some(m) => match m.as_str().to_lowercase().as_str() {
                    "bip44" => wallet_creation::GenMethod::Bip44,
                    "eip2333" => wallet_creation::GenMethod::Eip2333,
                    _ => wallet_creation::GenMethod::Bip44,
                },
                None => wallet_creation::GenMethod::Bip44,
            },
            coin_type: config.coin_type.unwrap_or(0),
            account_index: config.account_index.unwrap_or(0),
            change: config.change.unwrap_or(0),
            address_index: config.address_index.unwrap_or(0),
            password: config.password.unwrap_or("".to_string()),
        }
    }
}

#[derive(Debug, Clone)]
pub struct WalletCreationResult {
    pub address: String,
    pub private_key: Option<String>,
    pub mnemonic: Option<String>,
}
