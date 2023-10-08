#[derive(serde::Serialize, serde::Deserialize)]
pub enum GenMethod {
    Bip44,
    // Bip49,
    Eip2333,
}
