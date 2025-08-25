class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String address;
  final DateTime joinDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.address,
    required this.joinDate,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? company,
    String? address,
    DateTime? joinDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      address: address ?? this.address,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'address': address,
      'joinDate': joinDate.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      company: json['company'],
      address: json['address'],
      joinDate: DateTime.parse(json['joinDate']),
    );
  }
}

class DomainOrder {
  final String id;
  final String domainName;
  final String status;
  final DateTime registrationDate;
  final DateTime expiryDate;
  final double price;
  final bool autoRenewal;

  DomainOrder({
    required this.id,
    required this.domainName,
    required this.status,
    required this.registrationDate,
    required this.expiryDate,
    required this.price,
    required this.autoRenewal,
  });

  int get daysUntilExpiry {
    return expiryDate.difference(DateTime.now()).inDays;
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiryDate);
  }

  bool get isExpiringSoon {
    return daysUntilExpiry <= 30 && daysUntilExpiry > 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domainName': domainName,
      'status': status,
      'registrationDate': registrationDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'price': price,
      'autoRenewal': autoRenewal,
    };
  }

  factory DomainOrder.fromJson(Map<String, dynamic> json) {
    return DomainOrder(
      id: json['id'],
      domainName: json['domainName'],
      status: json['status'],
      registrationDate: DateTime.parse(json['registrationDate']),
      expiryDate: DateTime.parse(json['expiryDate']),
      price: json['price'].toDouble(),
      autoRenewal: json['autoRenewal'],
    );
  }
}