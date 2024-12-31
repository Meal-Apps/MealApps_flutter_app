// To parse this JSON data, do
//
//     final previousMonthExpenses = previousMonthExpensesFromJson(jsonString);

import 'dart:convert';

PreviousMonthExpenses previousMonthExpensesFromJson(String str) => PreviousMonthExpenses.fromJson(json.decode(str));

String previousMonthExpensesToJson(PreviousMonthExpenses data) => json.encode(data.toJson());

class PreviousMonthExpenses {
  List<PreviousMonthExpense> previousMonthExpense;
  int totalpreviousMonthExpenses;

  PreviousMonthExpenses({
    required this.previousMonthExpense,
    required this.totalpreviousMonthExpenses,
  });

  factory PreviousMonthExpenses.fromJson(Map<String, dynamic> json) => PreviousMonthExpenses(
    previousMonthExpense: List<PreviousMonthExpense>.from(json["previousMonthExpenses"].map((x) => PreviousMonthExpense.fromJson(x))),
    totalpreviousMonthExpenses: json["totalpreviousMonthExpenses"],
  );

  Map<String, dynamic> toJson() => {
    "previousMonthExpenses": List<dynamic>.from(previousMonthExpense.map((x) => x.toJson())),
    "totalpreviousMonthExpenses": totalpreviousMonthExpenses,
  };
}

class PreviousMonthExpense {
  int id;
  int managerId;
  int amount;
  String description;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;

  PreviousMonthExpense({
    required this.id,
    required this.managerId,
    required this.amount,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PreviousMonthExpense.fromJson(Map<String, dynamic> json) => PreviousMonthExpense(
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
