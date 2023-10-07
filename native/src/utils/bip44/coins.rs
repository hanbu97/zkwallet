use super::Bip44;

pub struct Solana;
impl Bip44 for Solana {
    const COIN: u32 = 501;
}

pub struct Ripple;
impl Bip44 for Ripple {
    const COIN: u32 = 144;
}
