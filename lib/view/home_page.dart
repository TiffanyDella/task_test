import 'package:flutter/material.dart';
import 'package:test_task/view/allVpn_widget.dart';
import 'package:test_task/view/favoriteVpn_widget.dart';
import 'package:test_task/core/model.dart';
import 'package:test_task/view/myVpn_widget.dart';
import 'package:test_task/core/vpnService.dart';
import 'tabbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<VpnServer> allServers = [];
  List<VpnServer> myServers = [];
  List<VpnServer> favoriteServers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(_onSearchChanged);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final all = await VpnService.getAllServers();
      final my = await VpnService.getMyServers();


      setState(() {
        allServers = all;
        myServers = my;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  Future<void> _toggleFavorite(VpnServer server) async {
    await VpnService.toggleFavorite(server, allServers, myServers);

    final updatedFavorites = [
      ...allServers.where((s) => s.isFavorite),
      ...myServers.where((s) => s.isFavorite),
    ];
    
    setState(() {
      favoriteServers = updatedFavorites;
    });
  }

  List<VpnServer> _filterServers(List<VpnServer> servers) {
    if (_searchQuery.isEmpty) return servers;
    return servers.where((server) => 
      server.city.toLowerCase().contains(_searchQuery) ||
      server.country.toLowerCase().contains(_searchQuery)
    ).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 40, 56),
        body: const Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 40, 56),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color.fromARGB(255, 26, 40, 56),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Выберите VPN сервер',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          CustomTabBar(controller: _tabController),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Поиск...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: const Color.fromARGB(255, 35, 50, 67),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AllVpnPage(
                  myServers: _filterServers(myServers),
                  allServers: _filterServers(allServers),
                  onToggleFavorite: _toggleFavorite,
                  searchQuery: _searchQuery,
                ),
                MyVpnPage(
                  servers: _filterServers(myServers),
                  onToggleFavorite: _toggleFavorite,
                  searchQuery: _searchQuery,
                ),
                FavoriteVpnPage(
                  servers: _filterServers(favoriteServers),
                  onToggleFavorite: _toggleFavorite,
                  searchQuery: _searchQuery,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}