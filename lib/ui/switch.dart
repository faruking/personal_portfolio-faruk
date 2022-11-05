import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_portfolio/ui/theme.dart';

class ToggleSwitch extends StatefulWidget {
  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Switch(
        value: _value,
        onChanged: (_) {
          setState(() {
            _value = !_value;
            themeChange.darkTheme = _value;
          });
        });
  }
}
