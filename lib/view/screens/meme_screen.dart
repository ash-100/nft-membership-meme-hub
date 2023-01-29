import 'package:flutter/material.dart';
import 'package:nft_membership_meme_hub/view/widgets/meme_card.dart';

class MemeScreen extends StatefulWidget {
  const MemeScreen({super.key});

  @override
  State<MemeScreen> createState() => _MemeScreenState();
}

class _MemeScreenState extends State<MemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            MemeCard(),
            MemeCard(),
          ],
        ),
      ),
    ));
  }
}
