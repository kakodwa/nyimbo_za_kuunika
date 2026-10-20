import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../providers/hymn_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/hymn_tile.dart';
import '../widgets/app_drawer.dart';
import '../utils/app_theme.dart';
import 'index_screen.dart';
import 'choruses_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isBottomBarVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isBottomBarVisible) {
          setState(() => _isBottomBarVisible = false);
        }
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_isBottomBarVisible) {
          setState(() => _isBottomBarVisible = true);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hymnProvider = Provider.of<HymnProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    // List of tab views including Favorites
    final pages = [
      // TAB 0: Main Hymns List
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Saka nambala kapena mutu...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.zecBlue),
                suffixIcon: hymnProvider.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          hymnProvider.setSearchQuery('');
                        },
                      )
                    : null,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => hymnProvider.setSearchQuery(value),
            ),
          ),
          Expanded(
            child: hymnProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : hymnProvider.filteredHymns.isEmpty
                    ? const Center(child: Text("Palibe nyimbo yomwe yapezeka."))
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: hymnProvider.filteredHymns.length,
                        itemBuilder: (context, index) {
                          return HymnTile(hymn: hymnProvider.filteredHymns[index]);
                        },
                      ),
          ),
        ],
      ),

      // TAB 1: Alphabetical Index
      IndexScreen(scrollController: _scrollController),

      // TAB 2: Choruses
      ChorusesScreen(scrollController: _scrollController),

      // TAB 3: Favorites / Zokondedwa Screen
      FavoritesScreen(scrollController: _scrollController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/logo.png',
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.menu_book_rounded,
                  color: AppTheme.zecGold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'NYIMBO ZA KUUNIKA',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(!themeProvider.isDarkMode),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          // Subtitle Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            color: AppTheme.zecDarkBlue,
            child: const Center(
              child: Text(
                '"Discipling Nations for Christ"',
                style: TextStyle(
                  color: AppTheme.zecLightGreen,
                  fontStyle: FontStyle.italic,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(child: pages[_currentIndex]),
        ],
      ),

      // Animated Bottom Navigation Bar
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        height: _isBottomBarVisible ? 75.0 : 0.0,
        child: Wrap(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: NavigationBar(
                  height: 60,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  selectedIndex: _currentIndex,
                  indicatorColor: AppTheme.zecGold.withOpacity(0.25),
                  onDestinationSelected: (idx) {
                    setState(() {
                      _currentIndex = idx;
                      _isBottomBarVisible = true;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.library_books_outlined),
                      selectedIcon: Icon(Icons.library_books, color: AppTheme.zecBlue),
                      label: 'Nyimbo',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.sort_by_alpha_outlined),
                      selectedIcon: Icon(Icons.sort_by_alpha, color: AppTheme.zecBlue),
                      label: 'Ndandanda',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.music_note_outlined),
                      selectedIcon: Icon(Icons.music_note, color: AppTheme.zecBlue),
                      label: 'Makorasi',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.favorite_border_rounded),
                      selectedIcon: Icon(Icons.favorite_rounded, color: Colors.redAccent),
                      label: 'Zokondedwa',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}