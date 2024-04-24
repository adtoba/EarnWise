import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class CreateExpertScreen extends ConsumerStatefulWidget {
  const CreateExpertScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateExpertScreenState();
}

class _CreateExpertScreenState extends ConsumerState<CreateExpertScreen> {

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 1,
        title: Text(
          "Create Expert Profile",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YMargin(30),
            const AppTextField(
              hint: "Title",
            ),
            const YMargin(20),
            const AppTextField(
              hint: "Description",
              maxLines: 4,
            ),
            const YMargin(20),
            Container(
              padding: EdgeInsets.symmetric(vertical: config.sh(8)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode ? Colors.white38 : Colors.grey
                )
              ),
              child: Row(
                children: [
                  const XMargin(10),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Colors.black26),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ))
                    ),
                    onPressed: () {},
                    child: Text(
                      "Select Cover Image", 
                      style: TextSizes.s14.copyWith(
                        color: Colors.white
                      )
                    ),
                  ),
                  const XMargin(20),
                  const Text(
                    "No File Chosen"
                  )
                ],
              ),
            ),
            const YMargin(20),
            const AppTextField(
              hint: "Select Category",
              suffix: Icon(Icons.arrow_drop_down),
            ),
            const YMargin(20),
            const AppTextField(
              hint: "Add Topics",
              suffix: Icon(Icons.arrow_drop_down),
            ),
            const YMargin(20),
            const AppTextField(
              hint: "Hourly rate",
              suffix: Icon(Icons.arrow_drop_down),
            ),
            const YMargin(5),
            const Text(
              "Your hourly income after fees (15%): \$51.00"
            ),
            const YMargin(20),
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
          child: AppButton(
            text: "Proceed",
            onPressed: () {},
          ),
        )
      ],
    );
  }
}