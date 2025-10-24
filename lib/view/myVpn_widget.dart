import 'package:flutter/material.dart';
import 'package:test_task/core/model.dart';


class MyVpnPage extends StatelessWidget {
  final List<VpnServer> servers;
  final Function(VpnServer) onToggleFavorite;
  final String searchQuery;

  const MyVpnPage({
    super.key,
    required this.servers,
    required this.onToggleFavorite,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 40, 56),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 35, 50, 67),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8.0)),
                  child: Icon(Icons.add, color: Colors.white),
                ),
                title: Text('Добавить ключ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ),
          Expanded(
            child: servers.isEmpty
                ? Center(child: Column(
            children: [searchQuery.isEmpty ? Text('Ваших серверов не найдено', style: TextStyle(color: Colors.white)) : Text('По вашему запросу серверов не найдено', style: TextStyle(color: Colors.white)),],
          ))
                : ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: servers.length,
                    itemBuilder: (context, index) {
                      final server = servers[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 35, 50, 67),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
                            child: Icon(Icons.public, color: Colors.white),
                          ),
                          title: Text(server.city, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                          subtitle: Text(server.ping, style: TextStyle(color: Colors.white70, fontSize: 14)),
                          trailing: IconButton(
                            icon: Icon(server.isFavorite ? Icons.star : Icons.star_border, color: server.isFavorite ? Colors.yellow : Colors.white54, size: 24),
                            onPressed: () => onToggleFavorite(server),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}