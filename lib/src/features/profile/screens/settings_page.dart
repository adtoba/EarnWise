import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 1,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const YMargin(20),
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text(
                  "Edit Profile",
                  style: TextSizes.s16.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Customize your profile",
                  style: TextSizes.s12,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.interests),
                title: Text(
                  "Your Interests",
                  style: TextSizes.s16.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Choose topics you're interested in",
                  style: TextSizes.s12,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.payment),
                title: Text(
                  "Payment",
                  style: TextSizes.s16.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Get paid & see all your transactions",
                  style: TextSizes.s12,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {},
              ),

              const Divider(height: 30),

              ListTile(
                leading: const Icon(Icons.monetization_on),
                title: Text(
                  "Your EarnWise Plan",
                  style: TextSizes.s14.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Manage your EarnWise subscription.",
                  style: TextSizes.s12,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.account_balance),
                title: Text(
                  "Connected Accounts",
                  style: TextSizes.s14.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Add your social media accounts to get verified",
                  style: TextSizes.s12,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(
                  "Notifications",
                  style: TextSizes.s14.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Customize your notification preferences",
                  style: TextSizes.s12,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {},
              ),

              const Divider(height: 30),

              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(
                  "Log Out",
                  style: TextSizes.s14.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Logout of your account",
                  style: TextSizes.s12,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}