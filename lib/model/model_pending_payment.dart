// lib/models/pending_payment.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class PendingPayment {
  final String id;
  final String name;
  final double price;
  final String userId;
  final DateTime timestamp;

  PendingPayment({
    required this.id,
    required this.name,
    required this.price,
    required this.userId,
    required this.timestamp,
  });

  // Convert PendingPayment to Map for Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'userId': userId,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  // Create PendingPayment from Firebase Map
  factory PendingPayment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PendingPayment(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      userId: data['userId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Optional: Create a copy of PendingPayment with some fields changed
  PendingPayment copyWith({
    String? id,
    String? name,
    double? price,
    String? userId,
    DateTime? timestamp,
  }) {
    return PendingPayment(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  // Optional: Compare two PendingPayment objects
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PendingPayment &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.userId == userId &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        userId.hashCode ^
        timestamp.hashCode;
  }
}
