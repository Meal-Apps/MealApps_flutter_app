// To parse this JSON data, do
//
//     final balance = balanceFromJson(jsonString);

import 'dart:convert';

Balance balanceFromJson(String str) => Balance.fromJson(json.decode(str));

String balanceToJson(Balance data) => json.encode(data.toJson());

class Balance {
  List<BalanceElement> balances;
  int totalBalance;

  Balance({
    required this.balances,
    required this.totalBalance,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
    balances: List<BalanceElement>.from(json["balances"].map((x) => BalanceElement.fromJson(x))),
    totalBalance: json["totalBalance"],
  );

  Map<String, dynamic> toJson() => {
    "balances": List<dynamic>.from(balances.map((x) => x.toJson())),
    "totalBalance": totalBalance,
  };
}

class BalanceElement {
  int id;
  int userId;
  int managerId;
  int balance;
  String userName;
  DateTime createdAt;
  DateTime updatedAt;

  BalanceElement({
    required this.id,
    required this.userId,
    required this.managerId,
    required this.balance,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BalanceElement.fromJson(Map<String, dynamic> json) => BalanceElement(
    id: json["id"],
    userId: json["user_id"],
    managerId: json["manager_id"],
    balance: json["balance"],
    userName: json["user_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "manager_id": managerId,
    "balance": balance,
    "user_name": userName,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
