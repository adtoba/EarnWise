import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/extensions.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class ConnectedAccountsScreen extends ConsumerStatefulWidget {
  const ConnectedAccountsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConnectedAccountsScreenState();
}

class _ConnectedAccountsScreenState extends ConsumerState<ConnectedAccountsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 1,
        title: Text(
          "Connected Accounts",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
        child: Column(
          children: [
            const YMargin(10),
            ListTile(
              leading: ImageIcon(
                AssetImage(
                  "instagram".png
                ),
                size: 30,
              ),
              title: Text(
                "Instagram",
                style: TextSizes.s16,
              ),
              subtitle: Text(
                "Connected",
                style: TextSizes.s12,
              ),
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage(
                  "twitter".png
                ),
                size: 30,
              ),
              title: Text(
                "Twitter",
                style: TextSizes.s16,
              ),
              subtitle: Text(
                "Connected",
                style: TextSizes.s12,
              ),
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage(
                  "linkedin".png
                ),
                size: 30,
              ),
              title: Text(
                "LinkedIn",
                style: TextSizes.s16,
              ),
              subtitle: Text(
                "Connected",
                style: TextSizes.s12,
              ),
            )
          ],
        ),
      ),
    );
  }
}