import 'package:earnwise/src/core/domain/dto/create_expert_profile_request.dart';
import 'package:earnwise/src/core/presentation/buttons/app_button.dart';
import 'package:earnwise/src/core/presentation/inputs/app_textfield.dart';
import 'package:earnwise/src/features/expert/screens/suggested_expert_topics_screen.dart';
import 'package:earnwise/src/features/expert/view_model/expert_vm.dart';
import 'package:earnwise/src/features/home/widgets/primary_loading_indicator.dart';
import 'package:earnwise/src/styles/text_sizes.dart';
import 'package:earnwise/src/utils/navigator.dart';
import 'package:earnwise/src/utils/size_config.dart';
import 'package:earnwise/src/utils/spacer.dart';
import 'package:earnwise/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';


class CreateExpertScreen extends ConsumerStatefulWidget {
  const CreateExpertScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateExpertScreenState();
}

class _CreateExpertScreenState extends ConsumerState<CreateExpertScreen> {

  final RegExp _numberRegExp = RegExp(r'^\d*\.?\d*$');

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final topicsController = TextEditingController();
  final descController = TextEditingController();
  final hourlyRateController = TextEditingController();

  String? selectedCategory;
  List<String> selectedTopics = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(expertViewModel).clearTopics();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var expertProvider = ref.watch(expertViewModel);
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return LoadingOverlay(
      isLoading: expertProvider.isLoading,
      progressIndicator: const PrimaryLoadingIndicator(),
      child: Scaffold(
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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(30),
                  AppTextField(
                    controller: titleController,
                    hint: "Title",
                    validator: Validators.validateField,
                  ),
                  const YMargin(20),
                  AppTextField(
                    controller: descController,
                    hint: "Description",
                    maxLines: 6,
                    validator: Validators.validateField,
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
                  AppTextField(
                    controller: categoryController,
                    hint: "Select Category",
                    suffix: const Icon(Icons.arrow_drop_down),
                  ),
                  const YMargin(20),
                  InkWell(
                    onTap: () async {
                      push(const SuggestedExpertTopicsScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: config.sh(52),
                      padding: EdgeInsets.symmetric(horizontal: config.sw(10)),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        // color: isDarkMode ? const Color(0xff525357) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode ? Colors.white38 : Colors.grey
                        )
                      ),
                      child: Text(
                        expertProvider.selectedTopics.isEmpty 
                          ? "Add Topics"
                          : expertProvider.selectedTopics.join(", "),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: config.sp(15),
                          fontWeight: FontWeight.normal,
                          color: expertProvider.selectedTopics.isEmpty 
                            ? isDarkMode ? Colors.white54 : Colors.grey
                            : isDarkMode ? Colors.white : Colors.black
                        ),
                      ),
                    ),
                  ),
                  const YMargin(20),
                  AppTextField(
                    controller: hourlyRateController,
                    hint: "Hourly rate",
                    keyboardType: const TextInputType.numberWithOptions(signed: true),
                    validator: Validators.validateField,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(_numberRegExp)
                    ],
                  ),
                  // const YMargin(5),
                  // const Text(
                  //   "Your hourly income after fees (15%): \$51.00"
                  // ),
                  const YMargin(20),
                ],
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: config.sw(20)),
            child: AppButton(
              text: "Proceed",
              onPressed: () {
                if(formKey.currentState!.validate()) {
                  expertProvider.createExpertProfile(CreateExpertProfileRequest(
                    title: titleController.text,
                    description: descController.text,
                    topics: expertProvider.selectedTopics,
                    hourlyRate: double.parse(hourlyRateController.text),
                    coverImage: "https://www.slideteam.net/media/catalog/product/cache/1280x720/s/o/software_company_profile_powerpoint_presentation_slides_slide01.jpg",
                    category: "Technology",
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}