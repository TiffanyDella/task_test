class VpnServer {
  final String id;
  final String city;
  final String ping;
  final String country;
  bool isFavorite;

  VpnServer({
    required this.id,
    required this.city,
    required this.ping,
    required this.country,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'ping': ping,
      'country': country,
      'isFavorite': isFavorite,
    };
  }

  factory VpnServer.fromJson(Map<String, dynamic> json) {
    return VpnServer(
      id: json['id'],
      city: json['city'],
      ping: json['ping'],
      country: json['country'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}