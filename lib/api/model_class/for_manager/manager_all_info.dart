// To parse this JSON data, do
//
//     final managerAllInfo = managerAllInfoFromJson(jsonString);

import 'dart:convert';

ManagerAllInfo managerAllInfoFromJson(String str) => ManagerAllInfo.fromJson(json.decode(str));

String managerAllInfoToJson(ManagerAllInfo data) => json.encode(data.toJson());

class ManagerAllInfo {
  Manager manager;
  List<User> users;
  List<Expense> expenses;
  List<Balance> balance;
  int totalExpenses;
  int totalBalance;
  int currentBalance;

  ManagerAllInfo({
    required this.manager,
    required this.users,
    required this.expenses,
    required this.balance,
    required this.totalExpenses,
    required this.totalBalance,
    required this.currentBalance,
  });

  factory ManagerAllInfo.fromJson(Map<String, dynamic> json) => ManagerAllInfo(
    manager: Manager.fromJson(json["manager"]),
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    expenses: List<Expense>.from(json["expenses"].map((x) => Expense.fromJson(x))),
    balance: List<Balance>.from(json["balance"].map((x) => Balance.fromJson(x))),
    totalExpenses: json["totalExpenses"],
    totalBalance: json["totalBalance"],
    currentBalance: json["currentBalance"],
  );

  Map<String, dynamic> toJson() => {
    "manager": manager.toJson(),
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
    "balance": List<dynamic>.from(balance.map((x) => x.toJson())),
    "totalExpenses": totalExpenses,
    "totalBalance": totalBalance,
    "currentBalance": currentBalance,
  };
}

class Balance {
  int id;
  int userId;
  int managerId;
  int balance;
  String userName;
  DateTime createdAt;
  DateTime updatedAt;

  Balance({
    required this.id,
    required this.userId,
    required this.managerId,
    required this.balance,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
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

class Expense {
  int id;
  int managerId;
  int amount;
  String description;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  Expense({
    required this.id,
    required this.managerId,
    required this.amount,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json["id"],
    managerId: json["manager_id"],
    amount: json["amount"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manager_id": managerId,
    "amount": amount,
    "description": description,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Manager {
  int id;
  String name;
  String email;
  String mealName;

  Manager({
    required this.id,
    required this.name,
    required this.email,
    required this.mealName,
  });

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mealName: json["meal_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "meal_name": mealName,
  };
}

class User {
  int id;
  String name;
  int managerId;
  String email;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.managerId,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    managerId: json["manager_id"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "manager_id": managerId,
    "email": email,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
