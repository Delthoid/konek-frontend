import 'package:flutter/material.dart';
import 'package:konek_frontend/config/sizing_config.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    this.title,
    this.width = 500,
    this.maxWidth = 700,
    required this.showCloseButton,
    required this.content,
  }) : assert(width <= maxWidth);

  final String? title;
  final Widget content;
  final double width;
  final double maxWidth;
  final bool showCloseButton;

  Widget _buildTitle() {
    if (title == null) {
      return Container();
    }

    return Text(title!, textAlign: TextAlign.center);
  }

  Widget _buildTitleHeader(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        if (showCloseButton || title == null) ...[
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: IconButton.filledTonal(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            ),
          ),
        ],
        Center(child: _buildTitle()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: _buildTitleHeader(context),
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      titlePadding: const EdgeInsets.all(SizingConfig.paddingMedium),
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(
          SizingConfig.borderRadiusXLarge,
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: width, maxWidth: maxWidth),
        child: content,
      ),
    );
  }
}
