import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hymn_provider.dart';
import '../widgets/hymn_tile.dart';

class IndexScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const IndexScreen({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hymnProvider = Provider.of<HymnProvider>(context);
    final sortedHymns = hymnProvider.alphabeticalHymns;

    return ListView.builder(
      controller: scrollController,
      itemCount: sortedHymns.length,
      itemBuilder: (context, idx) {
        return HymnTile(hymn: sortedHymns[idx]);
      },
    );
  }
}