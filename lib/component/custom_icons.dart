import 'package:flutter/material.dart';

class CategoryIcons {
  static IconData getIcon(String category) {
    switch (category.toLowerCase()) {
      case "groceries":
        return Icons.shopping_cart;
      case "salary":
      case "salaries":
        return Icons.attach_money;
      case "transport":
        return Icons.directions_bus;
      case "entertainment":
        return Icons.movie;
      case "rent":
        return Icons.home;
      case "food":
        return Icons.restaurant;
      default:
        return Icons.receipt_long; // fallback generic icon
    }
  }
}
