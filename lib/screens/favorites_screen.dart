import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/hymn_tile.dart';
import '../utils/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const FavoritesScreen({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hymnProvider = Provider.of<HymnProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    // Filter only saved/favorite hymns
    final favoriteHymns = hymnProvider.hymns
        .where((hymn) => settingsProvider.isFavorite(hymn.number))
        .toList();

    if (favoriteHymns.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.zecGold.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border_rounded,
                  color: AppTheme.zecGold,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Palibe Nyimbo Zokondedwa',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.zecBlue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Dinani chizindikiro cha mtima pa nyimbo iliyonse kuti muisunge muno.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.4),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: favoriteHymns.length,
      itemBuilder: (context, idx) {
        return HymnTile(hymn: favoriteHymns[idx]);
      },
    );
  }
}