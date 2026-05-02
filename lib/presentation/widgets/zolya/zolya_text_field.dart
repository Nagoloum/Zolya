import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ZolyaTextField extends StatelessWidget {
  const ZolyaTextField({
    super.key,
    this.label,
    this.placeholder,
    this.helper,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.leading,
    this.trailing,
    this.autofocus = false,
    this.focusNode,
    this.id,
  });

  final String? label;
  final String? placeholder;
  final String? helper;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final FormFieldValidator<String>? validator;

  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? leading;
  final Widget? trailing;
  final bool autofocus;
  final FocusNode? focusNode;
  final Object? id;

  String? Function(String)? get _shadValidator {
    if (validator == null) return null;
    return (v) => validator!(v);
  }

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      id: id,
      controller: controller,
      initialValue: initialValue,
      enabled: enabled,
      label: label != null ? Text(label!) : null,
      description: helper != null ? Text(helper!) : null,
      placeholder: placeholder != null ? Text(placeholder!) : null,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: _shadValidator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      leading: leading,
      trailing: trailing,
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }
}
