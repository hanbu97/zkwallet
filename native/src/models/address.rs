#[derive(Debug, Default)]
pub struct WalletAddress {
    pub mnemonic_phrase: String,
    pub secret_key: String,
    pub address: String,
}
