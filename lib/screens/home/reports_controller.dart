import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryExpense {
  final String name;
  final double amount;
  final Color color;

  CategoryExpense(this.name, this.amount, this.color);
}

class MonthlyExpense {
  final String month;
  final double amount;

  MonthlyExpense(this.month, this.amount);
}

class ReportsController extends GetxController {
  // Pie chart data
  var categories = <CategoryExpense>[
    CategoryExpense("Food", 420, Colors.blueAccent),
    CategoryExpense("Transport", 180, Colors.greenAccent),
    CategoryExpense("Shopping", 250, Colors.orangeAccent),
    CategoryExpense("Bills", 300, Colors.redAccent),
  ].obs;

  // Bar chart data
  var monthlyExpenses = <MonthlyExpense>[
    MonthlyExpense("Jan", 900),
    MonthlyExpense("Feb", 750),
    MonthlyExpense("Mar", 1100),
    MonthlyExpense("Apr", 860),
    MonthlyExpense("May", 940),
  ].obs;

  String get biggestExpense {
    var max = categories.reduce((a, b) => a.amount > b.amount ? a : b);
    return "Your biggest expense this month: ${max.name} 💸";
  }
}
