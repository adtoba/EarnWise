import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingScreen extends ConsumerStatefulWidget {
  const UpcomingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends ConsumerState<UpcomingScreen> {

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
          trailing: const Icon(Icons.arrow_forward_ios, size: 20),
        );
      },
      itemCount: 2,
    );
  }
}