class Domain {
  final String name;
  final String status;
  final DateTime expiryDate;
  final DateTime registrationDate;
  final double price;

  Domain({
    required this.name,
    required this.status,
    required this.expiryDate,
    required this.registrationDate,
    required this.price,
  });

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      name: json['name'],
      status: json['status'],
      expiryDate: DateTime.parse(json['expiryDate']),
      registrationDate: DateTime.parse(json['registrationDate']),
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'expiryDate': expiryDate.toIso8601String(),
      'registrationDate': registrationDate.toIso8601String(),
      'price': price,
    };
  }
}

class ActivityItem {
  final String title;
  final String description;
  final DateTime timestamp;
  final String type;

  ActivityItem({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
  });
}