import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana_mobile_wallet/solana_mobile_wallet.dart';
import 'package:flutter/material.dart';
import 'package:waterspay/utils/log/logger.dart';

class TestSolanaPage extends StatefulWidget {
  const TestSolanaPage({super.key});

  @override
  State<TestSolanaPage> createState() => _TestSolanaPageState();
}

class _TestSolanaPageState extends State<TestSolanaPage> {
  final _client = RpcClient('https://api.testnet.solana.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        TextButton(
            onPressed: () async {
              final balance = await _client
                  .getBalance('2FcU9vJueF47tQDe8BkQ8rBmgX5iYJ2FKtoHxZmN6AnR');

              LogUtil.debug(balance.value);
            },
            child: const Text('Balance'))
      ]),
    );
  }
}
