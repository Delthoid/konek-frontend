import 'package:flutter/material.dart';
import 'package:konek_frontend/config/sizing_config.dart';

class LabeledTextAreaField extends StatelessWidget {
  const LabeledTextAreaField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.hintText,
    this.maxLines = 5,
    this.maxLength = 255,
  });

  final String label;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int maxLines;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: theme.textTheme.bodyMedium,
            children: [
              if (validator != null)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: SizingConfig.spacingXSmall),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
          validator: validator,
          maxLines: maxLines,
          maxLength: maxLength,
        ),
      ],
    );
  }
}
