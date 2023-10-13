const List<String> defaultChains = ["solana", "vara"];
const Map<String, dynamic> chainsConfig = {
  "solana": {
    "id": "solana",
    "family": "sol",
    "name": "Solana",
    "symbol": "SOL",
    "chainId": 501,
    "decimal": 9,
    "hash": "ed25519",
    "rpc": [
      {"https://api.testnet.solana.com": []}
    ],
    "wss": [
      {"wss://testnet.solana.com/": []}
    ]
  },
  "vara": {
    "id": "vara",
    "family": "dot",
    "name": "Vara Network",
    "symbol": "VARA",
    "ss58": 137,
    "decimal": 12,
    "hash": "ed25519",
    "rpc": [
      {'wss://testnet.vara.rs': []}
    ],
    "wss": [
      {"wss://testnet.vara.rs": []}
    ]
  }
};
