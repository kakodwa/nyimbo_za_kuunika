import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../models/hymn_model.dart';
import '../providers/settings_provider.dart';
import '../widgets/text_size_slider.dart';
import '../utils/app_theme.dart';

class HymnDetailScreen extends StatefulWidget {
  final Hymn hymn;

  const HymnDetailScreen({Key? key, required this.hymn}) : super(key: key);

  @override
  State<HymnDetailScreen> createState() => _HymnDetailScreenState();
}

class _HymnDetailScreenState extends State<HymnDetailScreen> {
  @override
  void initState() {
    super.initState();
    WakelockPlus.enable(); // Prevents screen sleep while viewing hymns
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final isFav = settings.isFavorite(widget.hymn.number);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nyimbo ${widget.hymn.number}'),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: isFav ? Colors.redAccent : Colors.white70,
            ),
            onPressed: () => settings.toggleFavorite(widget.hymn.number),
          ),
          IconButton(
            icon: const Icon(Icons.format_size_rounded),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => const SizedBox(height: 110, child: TextSizeSlider()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Soft Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.zecBlue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppTheme.zecBlue.withOpacity(0.12)),
              ),
              child: Text(
                '${widget.hymn.number}. ${widget.hymn.title}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.zecBlue,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Verses & Chorus Cards
            ...widget.hymn.verses.map((verse) {
              final isVerseOne = verse.trim().startsWith("1.");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      verse,
                      style: TextStyle(fontSize: settings.fontSize, height: 1.65),
                    ),
                  ),
                  const SizedBox(height: 14),

                  if (isVerseOne && widget.hymn.chorus != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.zecGold.withOpacity(0.08),
                        border: const Border(
                          left: BorderSide(color: AppTheme.zecGold, width: 5),
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.music_note_rounded, size: 16, color: AppTheme.zecBlue),
                              SizedBox(width: 4),
                              Text(
                                'KORASI',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.zecBlue,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.hymn.chorus!,
                            style: TextStyle(
                              fontSize: settings.fontSize,
                              fontStyle: FontStyle.italic,
                              height: 1.65,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ],
              );
            }).toList(),

            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Built for ZEC by Isaac Kakodwa (IK-Pixels Tech)',
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}