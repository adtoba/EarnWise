import 'package:earnwise/src/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AppTextField extends StatefulWidget {
  const AppTextField({
    Key? k,
    this.label,
    this.onChanged,
    this.onTap,
    this.focusNode,
    this.hasFocus = false,
    this.prefix,
    this.nextNode,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.maxLines = 1,
    this.inputFormatters,
    this.suffix,
    this.hint,
    this.onEditingComplete,
    this.isSearchField = false,
    this.isPassword = false,
    this.isDense = false,
    this.controller,
    this.floatingLabelBehavior
  }) : super(key: k);

  final String? hint;
  final String? label;
  final Function()? onEditingComplete;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool? hasFocus;
  final bool enabled;
  final int maxLines;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final FocusNode? nextNode;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool isDense;
  final bool isSearchField;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final Widget? suffix;
  final Widget? prefix;
  final FloatingLabelBehavior? floatingLabelBehavior;

  @override
  State<AppTextField> createState() => _FiatTextFieldState();
}

class _FiatTextFieldState extends State<AppTextField> {

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      enabled: widget.enabled,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: config.sp(14),
      ),
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      validator: widget.validator,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: (String val) {
        FocusScope.of(context).requestFocus(widget.nextNode);
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        isDense: widget.isDense,
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefix,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        labelStyle: TextStyle(
          fontSize: config.sp(15),
          fontWeight: FontWeight.normal,
          color: isDarkMode ? Colors.white70 : Colors.grey
        ),
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
        filled: false,
        fillColor: isDarkMode ? const Color(0xff525357) : Colors.white,
        errorStyle: TextStyle(
          fontSize: config.sp(14),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white38 : Colors.grey
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: border.copyWith(
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white38 : Colors.grey
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white38 : Colors.grey
          )
        )
      ),
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Colors.white38
    )
  );
}