import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/features/dashboard/screens/dashboard.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class RequestCallSuccessPage extends StatefulWidget {
  const RequestCallSuccessPage({super.key});

  @override
  State<RequestCallSuccessPage> createState() => _RequestCallSuccessPageState();
}

class _RequestCallSuccessPageState extends State<RequestCallSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              pushAndRemoveUntil(const DashboardScreen());
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/success.json",
              height: config.sh(200),
              width: config.sw(200),
              alignment: Alignment.center
            ),
            Text(
              "Request Sent",
              style: TextSizes.s22.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            const YMargin(20),
            Text(
              "Your call request has been sent to Adebisi Habib. We will let you know when they accept your request.",
              textAlign: TextAlign.center,
              style: TextSizes.s14.copyWith(
                fontWeight: FontWeight.normal
              ),
            ),
            const YMargin(50),
            AppButton(
              text: "Go Home",
              onPressed: () {
                pushAndRemoveUntil(const DashboardScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}