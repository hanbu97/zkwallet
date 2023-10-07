// use std::convert::Infallible;
// use thiserror::Error;

use derivation_path::ChildIndex;

pub mod coins;
pub mod keypair;
pub mod path;

pub use path::DerivationPath;
pub trait Bip44 {
    const PURPOSE: u32 = 44;
    const COIN: u32;

    fn base_indexes(&self) -> Vec<ChildIndex> {
        vec![
            ChildIndex::Hardened(Self::PURPOSE),
            ChildIndex::Hardened(Self::COIN),
        ]
    }
}
