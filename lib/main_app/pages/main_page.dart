import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konek_frontend/core/widgets/dialog/custom_alert_dialog.dart';
import 'package:konek_frontend/core/widgets/dialog/custom_status_alert_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          ...AlertDialogStatusType.values.map((status) {
            return FilledButton(
              onPressed: () {
                CustomStatusAlertDialog.show(
                  context: context,
                  type: status,
                  title: 'Test title',
                  description: 'The quick brown fox jump over the lazy dog',
                  showCloseIcon: false,
                );
              },
              child: Text(status.name),
            );
          }).toList(),
        ],
      ),
    );
  }
}
