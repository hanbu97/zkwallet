use crate::{
    models::wallet_create::{CreationConfig, WalletCreationConfig, WalletCreationResult},
    utils::{
        bip44::{self, keypair::Keypair, path::DerivationPath},
        sign::Signer,
    },
};
use bitcoin::base58;

use super::{sanitize_seed_phrase, WalletOperations};

// // pub mod signature;
// // pub mod singer;
// use super::*;
// // pub mod public_key;
// // use solana_sdk::signature::Signer;
// // pub mod derivation_path;

pub struct SolWallet {}

impl WalletOperations for SolWallet {
    // impl SolWallet {
    fn import_private_key(
        &self,
        private_key: &str,
        wallet_type: Option<&str>,
    ) -> anyhow::Result<WalletCreationResult> {
        let private_key_bytes = base58::decode(private_key)
            .map_err(|e| anyhow::anyhow!(format!("Failed to decode private key: {}", e)))?;

        // 从私钥字节创建 Solana 密钥对
        let keypair = Keypair::from_bytes(&private_key_bytes)?;

        // 获取公钥并将其转换为字符串形式的地址
        let address = keypair.pubkey().to_string();

        // 返回创建的钱包结果
        Ok(WalletCreationResult {
            address,
            private_key: None,
            mnemonic: None,
        })
    }

    fn import_mnemonic(
        &self,
        mnemonic: &str,
        config: WalletCreationConfig,
        wallet_type: Option<&str>,
    ) -> anyhow::Result<WalletCreationResult> {
        let config = CreationConfig::from(config);
        let sanitized = sanitize_seed_phrase(mnemonic);
        let mnemonic = bip39::Mnemonic::from_phrase(&sanitized, config.lang)?;
        let seed = bip39::Seed::new(&mnemonic, "");

        // m/44'/501'/0'/0'
        // let derivation_path = solana_sdk::derivation_path::DerivationPath::new_bip44(
        //     Some(config.account_index),
        //     Some(config.change),
        // );

        // let address = keypair_from_seed_and_derivation_path(seed.as_bytes(), Some(derivation_path))
        //     ?;
        let derivation_path = DerivationPath::new_bip44_with_coin(
            bip44::coins::Solana,
            Some(config.account_index),
            Some(config.change),
        );

        let address = bip44::keypair::keypair_from_seed_and_derivation_path(
            seed.as_bytes(),
            derivation_path,
        )?;

        let bytes = address.to_bytes();
        let address = Keypair::from_bytes(&bytes)?;

        // 返回创建的钱包结果
        Ok(WalletCreationResult {
            address: address.pubkey().to_string(),
            private_key: Some(base58::encode(&address.to_bytes())),
            mnemonic: None,
        })
    }

    // fn create(
    //     &self,
    //     config: WalletCreationConfig,
    //     wallet_type: Option<&str>,
    // ) -> anyhow::Result<WalletCreationResult> {
    //     let con = CreationConfig::from(config.clone());
    //     let secret = wallet_creation::SecretPhrase::generate(con.lang, con.length);
    //     let phrase = secret.phrase();

    //     let mut address = self.import_mnemonic(phrase, config, wallet_type)?;
    //     address.mnemonic = Some(phrase.to_string());

    //     Ok(address)
    // }
}

#[test]
fn test_import_mnemonic() {
    let mnemonic = "soft east decide trash census retire where wonder benefit desert gown inside";
    let wallet = SolWallet {};
    let config = WalletCreationConfig {
        use_mnemonic: None,
        lang: None,
        length: None,
        method: None,
        coin_type: None,
        account_index: None,
        change: None,
        address_index: None,
        password: None,
    };
    let result = wallet.import_mnemonic(mnemonic, config, None).unwrap();

    dbg!(result);
}

#[test]
fn test_import() {
    let private_key =
        "4xDYRPbCBD3Nonmt8FWYg36dajkaBdR623KbCpd2rBzSsxRfMqwYCuSL6Ur4qATyYed9pGCm5miUGe3gdJLxRLey";
    let wallet = SolWallet {};
    let result = wallet.import_private_key(private_key, None).unwrap();
    dbg!(result);
}

// 4xDYRPbCBD3Nonmt8FWYg36dajkaBdR623KbCpd2rBzSsxRfMqwYCuSL6Ur4qATyYed9pGCm5miUGe3gdJLxRLey
// 4xDYRPbCBD3Nonmt8FWYg36dajkaBdR623KbCpd2rBzSsxRfMqwYCuSL6Ur4qATyYed9pGCm5miUGe3gdJLxRLey

// 9Y2Pv12c2KABudfyPuCBMzFfHdgpjMkAxAQ6rjrhvMsB
// 9Y2Pv12c2KABudfyPuCBMzFfHdgpjMkAxAQ6rjrhvMsB
