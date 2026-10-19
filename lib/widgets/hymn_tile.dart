import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hymn_model.dart';
import '../providers/settings_provider.dart';
import '../utils/app_theme.dart';
import '../screens/hymn_detail_screen.dart';

class HymnTile extends StatelessWidget {
  final Hymn hymn;

  const HymnTile({Key? key, required this.hymn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isFav = settingsProvider.isFavorite(hymn.number);

    final String subtitlePreview = hymn.verses.isNotEmpty
        ? hymn.verses.first.split('\n').first
        : 'Nyimbo ${hymn.number}';

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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.zecBlue,
                  AppTheme.zecBlue.withOpacity(0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${hymn.number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          title: Text(
            hymn.title.isNotEmpty ? hymn.title : 'Nyimbo ${hymn.number}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              subtitlePreview,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white60
                    : Colors.black54,
              ),
            ),
          ),
          trailing: IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
              child: Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey<bool>(isFav),
                color: isFav ? Colors.redAccent : Colors.grey.shade400,
                size: 22,
              ),
            ),
            onPressed: () => settingsProvider.toggleFavorite(hymn.number),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HymnDetailScreen(hymn: hymn),
              ),
            );
          },
        ),
      ),
    );
  }
}