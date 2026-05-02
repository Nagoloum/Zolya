import 'package:flutter/material.dart';

import '../../../widgets/zolya/zolya.dart';

class SearchInputBar extends StatelessWidget {
  const SearchInputBar({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.onMicTap,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onMicTap;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return ZolyaSearchField(
      controller: controller,
      hint: hint,
      autofocus: autofocus,
      onChanged: onChanged,
    );
  }
}
