use crate::models::wallet_create::{WalletCreationConfig, WalletCreationResult};

pub mod sol;

pub enum SupportChains {
    Sol,
    Gear,
}

impl From<String> for SupportChains {
    fn from(value: String) -> Self {
        match value.to_lowercase().as_str() {
            "sol" => SupportChains::Sol,
            "gear" => SupportChains::Gear,
            _ => SupportChains::Sol,
        }
    }
}

pub trait WalletOperations {
    // fn create(
    //     &self,
    //     config: WalletCreationConfig,
    //     wallet_type: Option<&str>,
    // ) -> anyhow::Result<WalletCreationResult>;
    fn import_private_key(
        &self,
        private_key: &str,
        wallet_type: Option<&str>,
    ) -> anyhow::Result<WalletCreationResult>;
    fn import_mnemonic(
        &self,
        mnemonic: &str,
        config: WalletCreationConfig,
        wallet_type: Option<&str>,
    ) -> anyhow::Result<WalletCreationResult>;
    // fn derive_sub_address(&self, index: u32) -> Result<String, &str>;
    // fn sign(&self, message: &[u8]) -> Result<Vec<u8>, &str>;
    // ...添加其他通用函数
}

pub fn sanitize_seed_phrase(seed_phrase: &str) -> String {
    seed_phrase
        .split_whitespace()
        .collect::<Vec<&str>>()
        .join(" ")
}
