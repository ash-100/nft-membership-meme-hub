import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:nft_membership_meme_hub/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.connector, this.session, this.uri});
  final connector, session, uri;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMember = false;
  String text = 'none';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    EthereumWalletConnectProvider provider =
        EthereumWalletConnectProvider(widget.connector);

    final contract = DeployedContract(
        ContractAbi.fromJson(json.encode(abi), 'MemeDaoNFT'),
        EthereumAddress.fromHex(contractAddress));

    var apiUrl =
        "https://eth-goerli.g.alchemy.com/v2/1rWqgPE_9gmXzr_2VO3h4yosLFrpY1uZ";
    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    ContractFunction isMemberFunction = contract.function('isMember');

    final val = await ethClient.call(
        contract: contract,
        function: isMemberFunction,
        params: [EthereumAddress.fromHex(widget.session.accounts[0])]);

    setState(() {
      text = val.toString();
      isMember = val[0] as bool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text(text)),
            isMember
                ? Text('you are a memeber')
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        final contract = DeployedContract(
                            ContractAbi.fromJson(
                                json.encode(abi), 'MemeDaoNFT'),
                            EthereumAddress.fromHex(contractAddress));
                        EthereumWalletConnectProvider provider =
                            EthereumWalletConnectProvider(widget.connector);
                        ContractFunction mintFunction =
                            contract.function('mint');
                        List<dynamic> args = [
                          EthereumAddress.fromHex(widget.session.accounts[0])
                        ];
                        final data = mintFunction.encodeCall(args);

                        launchUrlString(widget.uri,
                            mode: LaunchMode.externalApplication);
                        var res = await provider.sendTransaction(
                            from: widget.session.accounts[0],
                            to: contractAddress,
                            data: data,
                            value: BigInt.from(0.001 * 1000000000000000000));
                        setState(() {
                          text = res.toString();
                          if (res.toString().trim().isNotEmpty) {
                            setState(() {
                              isMember = true;
                            });
                          }
                        });
                      } catch (e) {
                        setState(() {
                          text = e.toString();
                        });
                      }
                    },
                    child: Text('Mint NFT Membership'))
          ],
        ),
      ),
    );
  }
}
