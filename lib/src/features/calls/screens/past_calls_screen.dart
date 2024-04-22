import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PastScreen extends ConsumerStatefulWidget {
  const PastScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PastScreenState();
}

class _PastScreenState extends ConsumerState<PastScreen> {

  @override
  Widget build(BuildContext context) {
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
            style: TextSizes.s14,
          ),
          subtitle: const Text(
            "2 days ago"
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 12),
        );
      },
      itemCount: 10,
    );
  }
}