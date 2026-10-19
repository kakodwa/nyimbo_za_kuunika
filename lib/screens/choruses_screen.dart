import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn_provider.dart';
import '../widgets/chorus_tile.dart';
import '../utils/app_theme.dart';

class ChorusesScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const ChorusesScreen({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hymnProvider = Provider.of<HymnProvider>(context);

    final olemekeza = hymnProvider.choruses.where((c) => c.category == 'Olemekeza').toList();
    final opembedza = hymnProvider.choruses.where((c) => c.category == 'Opembedza').toList();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: AppTheme.zecBlue,
            indicatorColor: AppTheme.zecGold,
            tabs: [
              Tab(text: 'OLEMEKEZA'),
              Tab(text: 'OPEMBEDZA'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: olemekeza.length,
                  itemBuilder: (_, idx) => ChorusTile(chorus: olemekeza[idx]),
                ),
                ListView.builder(
                  controller: scrollController,
                  itemCount: opembedza.length,
                  itemBuilder: (_, idx) => ChorusTile(chorus: opembedza[idx]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}