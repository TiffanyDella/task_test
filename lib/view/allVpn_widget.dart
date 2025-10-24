import 'package:flutter/material.dart';
import 'package:test_task/core/model.dart';

class AllVpnPage extends StatelessWidget {
  final List<VpnServer> myServers;
  final List<VpnServer> allServers;
  final Function(VpnServer) onToggleFavorite;
  final String searchQuery;

  const AllVpnPage({
    super.key,
    required this.myServers,
    required this.allServers,
    required this.onToggleFavorite,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasMyServers = myServers.isNotEmpty;
    final bool hasAllServers = allServers.isNotEmpty;

    if (!hasMyServers && !hasAllServers) {
      return Center(child: Column(
            children: [searchQuery.isEmpty ? Text('серверы не найдены', style: TextStyle(color: Colors.white)) : Text('По вашему запросу серверов не найдено', style: TextStyle(color: Colors.white)),],
          ));
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Мои точки доступа',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 35, 50, 67),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            leading: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8.0)),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            title: const Text('Добавить ключ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
        ...myServers.map((server) => _buildServerItem(server)).toList(),

        if (hasAllServers) ..._buildGroupedServers(allServers),
      ],
    );
  }


  List<Widget> _buildGroupedServers(List<VpnServer> servers) {
    final Map<String, List<VpnServer>> grouped = {};
    for (var server in servers) {
      if (!grouped.containsKey(server.country)) {
        grouped[server.country] = [];
      }
      grouped[server.country]!.add(server);
    }

    return [
      for (var entry in grouped.entries) ...[
        const SizedBox(height: 20),
        Text(entry.key, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...entry.value.map((server) => _buildServerItem(server)).toList(),
      ]
    ];
  }

  Widget _buildServerItem(VpnServer server) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 35, 50, 67),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
          child: const Icon(Icons.public, color: Colors.white),
        ),
        title: Text(server.city, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
        subtitle: Text(server.ping, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        trailing: IconButton(
          icon: Icon(
            server.isFavorite ? Icons.star : Icons.star_border, 
            color: server.isFavorite ? Colors.yellow : Colors.white54, 
            size: 24
          ),
          onPressed: () => onToggleFavorite(server),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}