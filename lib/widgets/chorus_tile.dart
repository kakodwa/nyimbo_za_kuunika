import 'package:flutter/material.dart';
import '../models/chorus_model.dart';
import '../utils/app_theme.dart';

class ChorusTile extends StatelessWidget {
  final Chorus chorus;

  const ChorusTile({Key? key, required this.chorus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.zecGold.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.music_note_rounded,
            color: AppTheme.zecGold,
            size: 22,
          ),
        ),
        title: Text(
          chorus.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}