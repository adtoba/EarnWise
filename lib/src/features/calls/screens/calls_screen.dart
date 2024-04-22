import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CallsScreen extends ConsumerStatefulWidget {
  const CallsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallsScreenState();
}

class _CallsScreenState extends ConsumerState<CallsScreen> {

  String? selectedTab = "Upcoming";

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 1,
        title: const Text(
          "Your Calls",
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
        child: Column(
          children: [
            const YMargin(20),
            Row(
              children: ["Upcoming", "Past"].map((e) {
                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      selectedTab = e;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: config.sw(5)),
                    padding: EdgeInsets.symmetric(horizontal: config.sw(20), vertical: config.sh(5)),
                    decoration: BoxDecoration(
                      color: selectedTab == e ? Colors.grey.shade700 : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      e,
                      style: TextSizes.s14.copyWith(
                        color: !isDarkMode && selectedTab == e  
                          ? Colors.white 
                          : isDarkMode && selectedTab == e
                          ? Colors.white
                          : isDarkMode && selectedTab != e
                          ? Colors.white
                          : Colors.black
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const YMargin(20),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(height: 20),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: const CircleAvatar(),
                    title: Text(
                      "Call with Adebisi Sulaimon to talk about something very urgent",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextSizes.s14,
                    ),
                    subtitle: const Text(
                      "In 30 mins"
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.primary
                          ),
                          child: const Icon(Icons.check, color: Colors.white),
                        ),
                        const XMargin(10),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red
                          ),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    )
                  );
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}