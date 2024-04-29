import 'package:earnwise/src/core/constants/metadata.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/features/expert/view_model/expert_vm.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestedExpertTopicsScreen extends ConsumerStatefulWidget {
  const SuggestedExpertTopicsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SuggestedExpertTopicsScreenState();
}

class _SuggestedExpertTopicsScreenState extends ConsumerState<SuggestedExpertTopicsScreen> {

  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    var expertProvider = ref.watch(expertViewModel);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        elevation: 1,
        title: Text(
          "Suggested Topics",
          style: TextStyle(
            fontSize: config.sp(22),
            fontFamily: GoogleFonts.raleway().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: config.sw(10)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              spacing: 7,
              runSpacing: 10,
              children: topics.map((e) {
                return InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    if(expertProvider.selectedTopics.contains(e)) {
                      setState(() {
                        expertProvider.removeTopic(e);
                      });
                    } else {
                      setState(() {
                        expertProvider.addTopic(e);
                      }); 
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(10)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: expertProvider.selectedTopics.contains(e) 
                        ? Colors.orange 
                        : Colors.transparent,
                      border: Border.all(
                        color: isDarkMode ? Colors.white38 : Colors.grey
                      )
                    ),
                    child: Text(
                      e,
                      style: TextSizes.s14.copyWith(
                        color: expertProvider.selectedTopics.contains(e) 
                          ? Colors.black 
                          : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ),
      persistentFooterButtons: [
        if(expertProvider.selectedTopics.isNotEmpty)...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
            child: AppButton(
              text: "Done",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ]
      ],
    );
  }
}