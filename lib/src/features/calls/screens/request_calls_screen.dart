import 'package:earnwise/src/core/domain/response/call_response.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/core/presentation/widgets/request_item_widget.dart';
import 'package:earnwise/src/features/calls/view_model/calls_vm.dart';
import 'package:earnwise/src/styles/palette.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';

class CallRequestsScreen extends ConsumerStatefulWidget {
  const CallRequestsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallRequestsScreenState();
}

class _CallRequestsScreenState extends ConsumerState<CallRequestsScreen> {

  @override
  Widget build(BuildContext context) {
    var callProvider = ref.watch(callViewModel);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YMargin(30),
          Row(
            children: [
              const XMargin(5),
              Text(
                "Received",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: config.sp(18),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, 
                child: const Text(
                  "See All"
                )
              ),
              const XMargin(5),
            ],
          ),
          if(callProvider.receivedCallRequests.isEmpty)...[
            Center(
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/empty_state.json",
                    height: config.sh(100),
                    width: config.sw(100),
                    alignment: Alignment.center
                  ),
                  const YMargin(10),
                  Text(
                    "You do not have any requests yet",
                    textAlign: TextAlign.center,
                    style: TextSizes.s14.copyWith(),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: config.sw(5)),
              separatorBuilder: (context, index) => Divider(height: 20, color: Colors.grey.withOpacity(.1)),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var request = callProvider.receivedCallRequests[index];
            
                return RequestItemWidget(
                  request: request,
                );
              },
              itemCount: callProvider.receivedCallRequests.take(4).length,
            ),
          ],
          

          const YMargin(30),

          Row(
            children: [
              const XMargin(5),
              Text(
                "Sent",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: config.sp(18)
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, 
                child: const Text(
                  "See All"
                )
              ),
              const XMargin(5),
            ],
          ),
          if(callProvider.sentCallRequests.isEmpty)...[
            Center(
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/empty_state.json",
                    height: config.sh(100),
                    width: config.sw(100),
                    alignment: Alignment.center
                  ),
                  const YMargin(10),
                  Text(
                    "You have not sent any new requests",
                    textAlign: TextAlign.center,
                    style: TextSizes.s14.copyWith(),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(height: 20),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var request = callProvider.sentCallRequests[index];
                
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  leading: const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      "assets/images/person.jpeg"
                    )
                  ),
                  title: Text(
                    "${request.reason}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextSizes.s14.copyWith(
                      color: isDarkMode ? Colors.white : Colors.black
                    ),
                  ),
                  subtitle: const Text(
                    "In 30 mins"
                  ),
                );
              },
              itemCount: callProvider.sentCallRequests.take(4).length,
            ),
          ],
          
        ],
      ),
    );
  }
}

class SelectSuggestedTimeWidget extends StatelessWidget {
  const SelectSuggestedTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: config.sw(10), vertical: config.sh(15)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey
          )
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Apr 23, 2024",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const XMargin(10),
            Container(
              height: config.sh(20),
              width: config.sw(1),
              color: Colors.grey,
            ),
            const XMargin(10),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "4:00 PM",
                      style: TextSizes.s16.copyWith(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}