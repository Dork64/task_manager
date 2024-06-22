import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/task_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text('Тёмная тема'),
          value: Provider.of<TaskProvider>(context).isDarkTheme,
          onChanged: (value) {
            Provider.of<TaskProvider>(context, listen: false).toggleTheme();
          },
        ),
      ),
    );
  }
}
