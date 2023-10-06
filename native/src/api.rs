// This is the entry point of your Rust library.
// When adding new code to your project, note that only items used
// here will be transformed to their Dart equivalents.

use crate::wallet::mnemonics::PolkadotAddress;

// A plain enum without any fields. This is similar to Dart- or C-style enums.
// flutter_rust_bridge is capable of generating code for enums with fields
// (@freezed classes in Dart and tagged unions in C).
pub enum Platform {
    Unknown,
    Android,
    Ios,
    Windows,
    Unix,
    MacIntel,
    MacApple,
    Wasm,
}

// A function definition in Rust. Similar to Dart, the return type must always be named
// and is never inferred.
pub fn platform() -> Platform {
    // This is a macro, a special expression that expands into code. In Rust, all macros
    // end with an exclamation mark and can be invoked with all kinds of brackets (parentheses,
    // brackets and curly braces). However, certain conventions exist, for example the
    // vector macro is almost always invoked as vec![..].
    //
    // The cfg!() macro returns a boolean value based on the current compiler configuration.
    // When attached to expressions (#[cfg(..)] form), they show or hide the expression at compile time.
    // Here, however, they evaluate to runtime values, which may or may not be optimized out
    // by the compiler. A variety of configurations are demonstrated here which cover most of
    // the modern oeprating systems. Try running the Flutter application on different machines
    // and see if it matches your expected OS.
    //
    // Furthermore, in Rust, the last expression in a function is the return value and does
    // not have the trailing semicolon. This entire if-else chain forms a single expression.
    if cfg!(windows) {
        Platform::Windows
    } else if cfg!(target_os = "android") {
        Platform::Android
    } else if cfg!(target_os = "ios") {
        Platform::Ios
    } else if cfg!(all(target_os = "macos", target_arch = "aarch64")) {
        Platform::MacApple
    } else if cfg!(target_os = "macos") {
        Platform::MacIntel
    } else if cfg!(target_family = "wasm") {
        Platform::Wasm
    } else if cfg!(unix) {
        Platform::Unix
    } else {
        Platform::Unknown
    }
}

// The convention for Rust identifiers is the snake_case,
// and they are automatically converted to camelCase on the Dart side.
pub fn rust_release_mode() -> bool {
    cfg!(not(debug_assertions))
}

pub fn multiply_zk(a: i32, b: i32) -> (String, String) {
    use ark_bn254::Bn254;
    use ark_circom::{read_zkey, CircomBuilder, CircomConfig};
    use ark_groth16::Groth16;
    use ark_snark::SNARK;
    // use ark_std::rand::thread_rng;
    type GrothBn = Groth16<Bn254>;
    use rand::thread_rng;

    // let cfg = CircomConfig::<Bn254>::new(
    //     "/Users/hanbu/MyApps/Gear/HackHouse/Codes/0918/arkcircom/test-vectors/circom2_multiplier2.wasm",
    //     "/Users/hanbu/MyApps/Gear/HackHouse/Codes/0918/arkcircom/test-vectors/circom2_multiplier2.r1cs",
    // ).map_err(|e|{
    //     return ("error：  CircomConfig::<Bn254>".to_string(),  e.to_string())
    // }).unwrap();

    let wtns_bytes = include_bytes!("/Users/hanbu/MyApps/Gear/HackHouse/Codes/0918/arkcircom/test-vectors/circom2_multiplier2.wasm");

    let store = wasmer::Store::default();
    let module = wasmer::Module::from_binary(&store, wtns_bytes).unwrap();
    let wtns = ark_circom::WitnessCalculator::from_module(module).unwrap();

    // let reader = std::fs::File::open(r1cs)?;
    let r1cs_bytes = include_bytes!("/Users/hanbu/MyApps/Gear/HackHouse/Codes/0918/arkcircom/test-vectors/circom2_multiplier2.r1cs");
    let cursor = std::io::Cursor::new(r1cs_bytes);
    let r1cs = ark_circom::circom::R1CSFile::new(cursor).unwrap().into();

    let cfg = CircomConfig::<Bn254> {
        r1cs,
        wtns,
        sanity_check: false,
    };

    let mut builder = CircomBuilder::new(cfg);
    builder.push_input("a", 3);
    builder.push_input("b", 11);

    // create an empty instance for setting it up
    let _ = builder.setup();

    let mut rng = thread_rng();

    // // params random generated
    // // let params = GrothBn::generate_random_parameters_with_reduction(circom, &mut rng)?;
    // // params from zkey
    // let path = "./test-vectors/test.zkey";
    // let mut file = std::fs::File::open(path).unwrap();
    // let (params, _matrices) = read_zkey(&mut file).unwrap();

    let zkey_bytes = include_bytes!(
        "/Users/hanbu/MyApps/Gear/HackHouse/Codes/0918/arkcircom/test-vectors/test.zkey"
    );
    let mut cursor = std::io::Cursor::new(zkey_bytes);
    let (params, _matrices) = read_zkey(&mut cursor).unwrap();

    let circom = builder.build().unwrap();

    // // Corresponding to circom2
    // // proof.json: it contains the proof.
    // // public.json: it contains the values of the public inputs and outputs.
    // // let inputs = circom.get_public_inputs().unwrap();
    let inputs: Vec<ark_ff::Fp<ark_ff::MontBackend<ark_bn254::FrConfig, 4>, 4>> =
        circom.get_public_inputs().unwrap();

    // let t = inputs[0].0;
    // let t1 = inputs[0].1;

    // println!("t: {}", t);
    // println!("t1: {:?}", t1);

    let proof = GrothBn::prove(&params, circom, &mut rng).unwrap();

    // let mut builder = CircomBuilder::new(cfg);
    // builder.push_input("a", a);
    // builder.push_input("b", b);

    // // create an empty instance for setting it up
    // let _ = builder.setup();

    // // let mut rng = thread_rng();

    // // params random generated
    // // let params = GrothBn::generate_random_parameters_with_reduction(circom, &mut rng)?;
    // // params from zkey
    // // let path =
    // //     "/Users/hanbu/MyApps/Gear/HackHouse/Codes/0918/arkcircom/test-vectors/test.zkey";
    // // let mut file = std::fs::File::open(path).unwrap();
    // // let (params, _matrices) = read_zkey(&mut file).unwrap();

    // let circom = builder
    //     .build()
    //     .map_err(|e| return ("error：  builder.build()".to_string(), e.to_string()))
    //     .unwrap();

    // // // Corresponding to circom2
    // // // proof.json: it contains the proof.
    // // // public.json: it contains the values of the public inputs and outputs.
    // // let proof = GrothBn::prove(&params, circom, &mut rng).unwrap();

    // let inputs: Vec<ark_ff::Fp<ark_ff::MontBackend<ark_bn254::FrConfig, 4>, 4>> =
    //     circom.get_public_inputs().unwrap_or({
    //         return (
    //             "error：  circom.get_public_inputs()".to_string(),
    //             "".to_string(),
    //         );
    //     });

    // let inputs = inputs
    //     .iter()
    //     .map(|x| )
    //     .collect::<Vec<String>>()
    //     .join('/');

    // let ou1 = format!("{:?}", inputs);
    // let ou2 = format!("{:?}", proof);
    // // let out = request_message.in1 * request_message.in2;

    // let ou1 = a.in1.to_string();
    // let ou2 = request_message.in2.to_string();

    // (a.to_string(), b.to_string())
    (format!("{:?}", inputs), format!("{:?}", proof))
}

// pub fn pwd_and_ls() -> (String, String) {
//     use std::process::Command;
//     let pwd = Command::new("pwd")
//         .output()
//         .expect("failed to execute process");
//     let ls = Command::new("ls")
//         .output()
//         .expect("failed to execute process");
//     let pwd = String::from_utf8(pwd.stdout).unwrap();
//     let ls = String::from_utf8(ls.stdout).unwrap();
//     (pwd, ls)
// }

fn get_language(lang: String) -> bip39::Language {
    match lang.as_str() {
        "English" => bip39::Language::English,
        "ChineseSimplified" => bip39::Language::ChineseSimplified,
        "ChineseTraditional" => bip39::Language::ChineseTraditional,
        "French" => bip39::Language::French,
        "Italian" => bip39::Language::Italian,
        "Japanese" => bip39::Language::Japanese,
        "Korean" => bip39::Language::Korean,
        "Spanish" => bip39::Language::Spanish,
        _ => bip39::Language::English,
    }
}

fn get_length(length: u8) -> bip39::MnemonicType {
    match length {
        12 => bip39::MnemonicType::Words12,
        15 => bip39::MnemonicType::Words15,
        18 => bip39::MnemonicType::Words18,
        21 => bip39::MnemonicType::Words21,
        24 => bip39::MnemonicType::Words24,
        _ => bip39::MnemonicType::Words12,
    }
}

pub fn generate_wallet(
    ss58: u16,
    password: Option<String>,
    length: u8,
    lang: String,
) -> PolkadotAddress {
    let length = get_length(length);
    let lang = get_language(lang);

    let data = crate::wallet::mnemonics::generate_wallet(ss58, password, length, lang);
    data
}

pub fn generate_wallet_from_mnemonics(
    ss58: u16,
    password: Option<String>,
    phrase: String,
    lang: String,
) -> PolkadotAddress {
    let phrase = phrase.trim();
    let lang = get_language(lang);

    let data =
        crate::wallet::mnemonics::generate_wallet_from_mnemonics(ss58, password, phrase, lang);
    data
}

pub fn word_suggestion(word: String, lang: String) -> Vec<String> {
    let lang = get_language(lang);
    let word = word.trim();
    let data = crate::wallet::mnemonics::word_suggestion(word, lang);
    data
}

#[test]
fn test_generate_wallet() {
    let data = generate_wallet(42, None, 12, "English".to_string());
    println!("data: {:?}", data);

    let data = generate_wallet(137, None, 24, "ChineseSimplified".to_string());
    println!("data: {:?}", data);
}

#[test]
fn test_mnemonic_words_suggestion() {
    let word = "ab";
    let lang = "English";

    let data = word_suggestion(word.to_string(), lang.to_string());
    dbg!(data);

    // let data = crate::wallet::mnemonics::mnemonic_words_suggestion(word, lang);
}

#[test]
fn test_generate_wallet_from_mnemonics() {
    let phrase =
        "sudden note pause benefit dash envelope crush secret flush desk east pepper".to_string();
    let lang = "English".to_string();
    let data = generate_wallet_from_mnemonics(42, None, phrase, lang);
    dbg!(data);
}
