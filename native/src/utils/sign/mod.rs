pub mod error;
use self::error::SignerError;

use super::pubkey::Pubkey;

/// The `Signer` trait declares operations that all digital signature providers
/// must support. It is the primary interface by which signers are specified in
/// `Transaction` signing interfaces
pub trait Signer {
    /// Infallibly gets the implementor's public key. Returns the all-zeros
    /// `Pubkey` if the implementor has none.
    fn pubkey(&self) -> Pubkey {
        self.try_pubkey().unwrap_or_default()
    }
    /// Fallibly gets the implementor's public key
    fn try_pubkey(&self) -> Result<Pubkey, SignerError>;
    // /// Infallibly produces an Ed25519 signature over the provided `message`
    // /// bytes. Returns the all-zeros `Signature` if signing is not possible.
    // fn sign_message(&self, message: &[u8]) -> Signature {
    //     self.try_sign_message(message).unwrap_or_default()
    // }
    // /// Fallibly produces an Ed25519 signature over the provided `message` bytes.
    // fn try_sign_message(&self, message: &[u8]) -> Result<Signature, SignerError>;
    /// Whether the impelmentation requires user interaction to sign
    fn is_interactive(&self) -> bool;
}
