import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'zolya_text_field.dart';

class ZolyaTextarea extends StatelessWidget {
  const ZolyaTextarea({
    super.key,
    this.label,
    this.placeholder,
    this.helper,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.minLines = 4,
    this.maxLines = 8,
    this.maxLength,
    this.inputFormatters,
  });

  final String? label;
  final String? placeholder;
  final String? helper;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return ZolyaTextField(
      label: label,
      placeholder: placeholder,
      helper: helper,
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
