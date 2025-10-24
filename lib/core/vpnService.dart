import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:test_task/core/model.dart';


class VpnService {
  // Загрузка из JSON файлов
  static Future<List<VpnServer>> loadServers(String fileName) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/$fileName');
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((json) => VpnServer.fromJson(json)).toList();
    } catch (e) {
      print('Error loading $fileName: $e');
      return [];
    }
  }

  static Future<List<VpnServer>> getAllServers() async {
    return await loadServers('all_servers.json');
  }

  static Future<List<VpnServer>> getMyServers() async {
    return await loadServers('my_servers.json');
  }

  static Future<List<VpnServer>> getFavoriteServers() async {
    return await loadServers('favorite_servers.json');
  }

  static Future<void> updateFavoriteServers(List<VpnServer> allServers, List<VpnServer> myServers) async {
    final List<VpnServer> allFavoriteServers = [
      ...allServers.where((server) => server.isFavorite),
      ...myServers.where((server) => server.isFavorite),
    ];

    final List<Map<String, dynamic>> jsonList = allFavoriteServers.map((server) => server.toJson()).toList();
    final String jsonString = json.encode(jsonList);
  }

  // Переключение избранного
  static Future<void> toggleFavorite(VpnServer server, List<VpnServer> allServers, List<VpnServer> myServers) async {
    server.isFavorite = !server.isFavorite;
    await updateFavoriteServers(allServers, myServers);
  }
}