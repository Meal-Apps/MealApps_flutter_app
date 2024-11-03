// To parse this JSON data, do
//
//     final expenses = expensesFromJson(jsonString);

import 'dart:convert';

Expenses expensesFromJson(String str) => Expenses.fromJson(json.decode(str));

String expensesToJson(Expenses data) => json.encode(data.toJson());

class Expenses {
  List<Expense> expenses;
  int totalExpenses;

  Expenses({
    required this.expenses,
    required this.totalExpenses,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) => Expenses(
    expenses: List<Expense>.from(json["expenses"].map((x) => Expense.fromJson(x))),
    totalExpenses: json["totalExpenses"],
  );

  Map<String, dynamic> toJson() => {
    "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
    "totalExpenses": totalExpenses,
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
