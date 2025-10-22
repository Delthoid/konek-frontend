import 'package:flutter/widgets.dart';
import 'package:konek_frontend/config/sizing_config.dart';

extension WidgetExtensions on Widget {
  // Paddings
  Widget withPaddingSymmetrical({
    double vertical = SizingConfig.paddingSmall,
    double horizontal = SizingConfig.paddingSmall,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }
}
