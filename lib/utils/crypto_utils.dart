import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart' as web3;
import 'package:web3dart/web3dart.dart';

class CryptoUtils {
  final web3.Web3Client web3Client = web3.Web3Client(
    'https://polygon-mainnet.g.alchemy.com/v2/7Ebi_aB7cpnrPqhxeULkr1brisWlLqd-',
    Client(),
  );

  static String trimHash(String hash) {
    try {
      return '${hash.substring(0, 10)}...${hash.substring(hash.length - 8, hash.length)}';
    } catch (error) {
      return 'Error...';
    }
  }

  Future<double> getBalance(String walletAddress) async {
    if (walletAddress.isEmpty) return 0;

    final List<dynamic> queryResult =
        await query('balanceOf', <web3.EthereumAddress>[
      web3.EthereumAddress.fromHex(
        walletAddress.toLowerCase(),
      ),
    ]);

    final web3.EtherAmount balanceResult =
        web3.EtherAmount.inWei(queryResult[0] as BigInt);
    final double balance = double.parse(balanceResult.getInEther.toString());

    return balance;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final Map<String, dynamic> contractInfo = await getContract();
    final web3.DeployedContract contract =
        contractInfo['contract'] as web3.DeployedContract;
    final web3.ContractFunction function = contract.function(functionName);
    final List<dynamic> result = await web3Client.call(
      contract: contract,
      function: function,
      params: args,
    );
    return result;
  }

  Future<Map<String, dynamic>> getContract() async {
    final String contractAsset =
        await rootBundle.loadString('lib/assets/json/DailyCopTokenChild.json');

    final Map<String, dynamic> contractJson =
        await json.decode(contractAsset) as Map<String, dynamic>;
    final dynamic contractAddress = contractJson['address'];
    final String contractAbi = json.encode(contractJson['abi']);
    final String relayerAddress = json.encode(contractJson['relayerAddress']);

    final DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(contractAbi, 'DailyCopTokenChild'),
      EthereumAddress.fromHex(contractAddress.toString()),
    );

    return <String, dynamic>{'contract': contract, 'rAddress': relayerAddress};
  }
}
