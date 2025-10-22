import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomFieldButton extends StatelessWidget {
  const CustomFieldButton({super.key, required this.text, required this.isLoading, this.onPressed});

  final String text;
  final bool isLoading;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? SpinKitCircle(size: 24, color: Theme.of(context).colorScheme.primary) : Text(text),
    );
  }
}
