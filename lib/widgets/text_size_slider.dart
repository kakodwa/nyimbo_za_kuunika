import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class TextSizeSlider extends StatelessWidget {
  const TextSizeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.text_fields, size: 16),
          Expanded(
            child: Slider(
              value: settings.fontSize,
              min: 14.0,
              max: 32.0,
              divisions: 9,
              label: "${settings.fontSize.toInt()}pt",
              onChanged: (newSize) {
                settings.setFontSize(newSize);
              },
            ),
          ),
          const Icon(Icons.text_fields, size: 28),
        ],
      ),
    );
  }
}