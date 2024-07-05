import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class AppDropDownDynamic<T> extends StatelessWidget {
  AppDropDownDynamic({
    Key? key,
    this.onChanged,
    this.validator,
    this.selected,
    @required this.options,
    this.suffix,
    @required this.getDisplayName,
    this.hint,
  }) : super(key: key);

  final String? Function(Object?)? validator;
  final List<T>? options;
  final Function(T?)? onChanged;
  final T? selected;
  final String? hint;
  final Widget? suffix;
  final String? Function(T)? getDisplayName;
  static SizeConfig config = SizeConfig();

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return SizedBox(
      height: config.sh(55),
      child: DropdownButtonFormField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        items: options!.map<DropdownMenuItem<T>>((f) {
          return DropdownMenuItem<T>(
            alignment: Alignment.centerLeft,
            value: f,
            child: Text(
              '${getDisplayName!(f)}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: config.sp(15),
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        value: selected,
        alignment: Alignment.center,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: config.sp(14),
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        decoration: InputDecoration(
            hintText: hint,
            filled: false,
            fillColor: isDarkMode ? const Color(0xff525357) : Colors.white,
            hintStyle: TextStyle(
              fontSize: config.sp(15),
              fontWeight: FontWeight.normal,
              color: isDarkMode ? Colors.white54 : Colors.grey
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white38 : Colors.grey
              )
            ),
            errorStyle: const TextStyle(
              color: Colors.red
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white38 : Colors.grey
              )
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white38 : Colors.grey
              )
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.white38 : Colors.grey
              )
            ),
        ),
        icon: suffix,
      ),
    );
  }
}