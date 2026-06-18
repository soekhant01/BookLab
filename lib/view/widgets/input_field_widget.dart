import 'package:flutter/material.dart';

import '../../const/theme/app_theme_tokens.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    super.key,
    required this.title,
    required this.hintName,
    required this.controller,
    required this.maxLines,
  });

  final String title;
  final String hintName;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    AppThemeTokens appThemeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: appThemeTokens.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.0),

        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintName,
            filled: true,
            fillColor: appThemeTokens.surface,

            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appThemeTokens.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appThemeTokens.primary),
            ),
          ),
        ),
      ],
    );
  }
}
