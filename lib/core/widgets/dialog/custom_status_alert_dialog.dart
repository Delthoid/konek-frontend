import 'package:flutter/material.dart';
import 'package:konek_frontend/config/sizing_config.dart';

enum AlertDialogStatusType { success, error, warning, info }

class CustomStatusAlertDialog extends StatelessWidget {
  const CustomStatusAlertDialog({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    this.showCloseIcon = false,
  });

  final AlertDialogStatusType type;
  final String title;
  final String description;
  final bool showCloseIcon;

  static Future<T?> show<T>({
    required BuildContext context,
    required AlertDialogStatusType type,
    required String title,
    required String description,
    bool showCloseIcon = true,
  }) async {
    return showDialog<T>(
      context: context,
      builder: (context) =>
          CustomStatusAlertDialog(type: type, title: title, description: description, showCloseIcon: showCloseIcon),
    );
  }

  Color get _statusColor {
    switch (type) {
      case AlertDialogStatusType.success:
        return Colors.green[50]!;
      case AlertDialogStatusType.info:
        return Colors.blue[50]!;
      case AlertDialogStatusType.error:
        return Colors.red[50]!;
      case AlertDialogStatusType.warning:
        return Colors.orange[50]!;
    }
  }

  Color get _statusColorPrimary {
    switch (type) {
      case AlertDialogStatusType.success:
        return Colors.green[700]!;
      case AlertDialogStatusType.info:
        return Colors.blue[700]!;
      case AlertDialogStatusType.error:
        return Colors.red[700]!;
      case AlertDialogStatusType.warning:
        return Colors.orange[700]!;
    }
  }

  IconData get _statusIcon {
    switch (type) {
      case AlertDialogStatusType.success:
        return Icons.check_circle_rounded;
      case AlertDialogStatusType.info:
        return Icons.info_outline_rounded;
      case AlertDialogStatusType.error:
        return Icons.error_outline_rounded;
      case AlertDialogStatusType.warning:
        return Icons.warning_amber_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(maxWidth: 400, minWidth: 400),
      child: Container(
        decoration: BoxDecoration(
          color: _statusColor,
          borderRadius: BorderRadius.circular(SizingConfig.borderRadiusLarge),
        ),
        padding: EdgeInsets.all(SizingConfig.spacingSmall),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showCloseIcon)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
              ),
            const SizedBox(height: SizingConfig.spacingSmall),
            Icon(_statusIcon, size: 48, color: _statusColorPrimary),
            const SizedBox(height: SizingConfig.spacingSmall),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(color: _statusColorPrimary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: SizingConfig.spacingSmall),
            Text(
              description,
              // style: theme.textTheme.titleLarge?.copyWith(color: _statusColorPrimary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: SizingConfig.spacingLarge),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
            ),
          ],
        ),
      ),
    );
  }
}
