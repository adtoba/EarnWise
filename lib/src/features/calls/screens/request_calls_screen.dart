import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallRequestsScreen extends ConsumerStatefulWidget {
  const CallRequestsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallRequestsScreenState();
}

class _CallRequestsScreenState extends ConsumerState<CallRequestsScreen> {

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(height: 20),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(
              "assets/images/person.jpeg"
            )
          ),
          title: Text(
            "Call with Adebisi Sulaimon to talk about how to become a successful photographer",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextSizes.s14.copyWith(
              color: isDarkMode ? Colors.white : Colors.black
            ),
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
      itemCount: 2,
    );
  }
}