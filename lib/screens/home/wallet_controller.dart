import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wallet {
  String name;
  String type;
  IconData icon;
  double balance;

  Wallet({
    required this.name,
    required this.type,
    required this.icon,
    required this.balance,
  });
}

class Loan {
  String name;
  double amount;
  DateTime dueDate;

  Loan({required this.name, required this.amount, required this.dueDate});
}

class WalletsController extends GetxController {
  // Reactive lists
  var wallets = <Wallet>[
    Wallet(name: "Cash", type: "Physical", icon: Icons.account_balance_wallet, balance: 350.00),
    Wallet(name: "Bank", type: "Savings Account", icon: Icons.account_balance, balance: 2450.75),
    Wallet(name: "e-Wallet", type: "Digital", icon: Icons.phone_android, balance: 820.25),
  ].obs;

  var loans = <Loan>[
    Loan(name: "Car Loan", amount: 500.00, dueDate: DateTime.now().add(const Duration(days: 12))),
    Loan(name: "Friend Borrow", amount: 120.00, dueDate: DateTime.now().add(const Duration(days: -5))),
  ].obs;

  // Reactive total balance
  var totalBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _calculateTotalBalance();
  }

  void _calculateTotalBalance() {
    totalBalance.value = wallets.fold(0.0, (sum, wallet) => sum + wallet.balance);
  }

  void addLoan(String name, double amount, DateTime dueDate) {
    loans.add(Loan(name: name, amount: amount, dueDate: dueDate));
  }

  // Optional: if wallet balances can change
  void updateWalletBalance(int index, double newBalance) {
    wallets[index].balance = newBalance;
    wallets.refresh();
    _calculateTotalBalance();
  }
}
