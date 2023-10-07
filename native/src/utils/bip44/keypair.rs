// use rand07::{rngs::OsRng, CryptoRng, RngCore};
use rand0_7::{rngs::OsRng, CryptoRng, RngCore};

use super::path::DerivationPath;
// use ed25519_dalek_bip32::Error as Bip32Error;

pub fn keypair_from_seed_and_derivation_path(
    seed: &[u8],
    derivation_path: DerivationPath,
) -> anyhow::Result<Keypair> {
    bip32_derived_keypair(seed, derivation_path)
}

/// Generates a Keypair using Bip32 Hierarchical Derivation
fn bip32_derived_keypair(seed: &[u8], derivation_path: DerivationPath) -> anyhow::Result<Keypair> {
    let extended = ed25519_dalek_bip32::ExtendedSecretKey::from_seed(seed)
        .and_then(|extended| extended.derive(&derivation_path))?;
    let extended_public_key = extended.public_key();
    Ok(Keypair(ed25519_dalek::Keypair {
        secret: extended.secret_key,
        public: extended_public_key,
    }))
}

/// A vanilla Ed25519 key pair
#[derive(Debug)]
pub struct Keypair(ed25519_dalek::Keypair);

impl Keypair {
    /// Constructs a new, random `Keypair` using a caller-provided RNG
    pub fn generate<R>(csprng: &mut R) -> Self
    where
        R: CryptoRng + RngCore,
    {
        Self(ed25519_dalek::Keypair::generate(csprng))
    }

    /// Constructs a new, random `Keypair` using `OsRng`
    pub fn new() -> Self {
        let mut rng = OsRng::default();
        Self::generate(&mut rng)
    }

    /// Recovers a `Keypair` from a byte array
    pub fn from_bytes(bytes: &[u8]) -> Result<Self, ed25519_dalek::SignatureError> {
        ed25519_dalek::Keypair::from_bytes(bytes).map(Self)
    }

    /// Returns this `Keypair` as a byte array
    pub fn to_bytes(&self) -> [u8; 64] {
        self.0.to_bytes()
    }

    /// Recovers a `Keypair` from a base58-encoded string
    pub fn from_base58_string(s: &str) -> Self {
        Self::from_bytes(&bs58::decode(s).into_vec().unwrap()).unwrap()
    }

    /// Returns this `Keypair` as a base58-encoded string
    pub fn to_base58_string(&self) -> String {
        bs58::encode(&self.0.to_bytes()).into_string()
    }

    /// Gets this `Keypair`'s SecretKey
    pub fn secret(&self) -> &ed25519_dalek::SecretKey {
        &self.0.secret
    }

    /// Allows Keypair cloning
    ///
    /// Note that the `Clone` trait is intentionally unimplemented because making a
    /// second copy of sensitive secret keys in memory is usually a bad idea.
    ///
    /// Only use this in tests or when strictly required. Consider using [`std::sync::Arc<Keypair>`]
    /// instead.
    pub fn insecure_clone(&self) -> Self {
        Self(ed25519_dalek::Keypair {
            // This will never error since self is a valid keypair
            secret: ed25519_dalek::SecretKey::from_bytes(self.0.secret.as_bytes()).unwrap(),
            public: self.0.public,
        })
    }

    // fn pubkey(&self) -> Pubkey {
    //     Pubkey::from(self.0.public.to_bytes())
    // }
}
