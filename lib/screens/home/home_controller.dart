import 'package:get/get.dart';
import '../../models/transaction_model.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  var transactions = <TransactionModel>[].obs;

  double get totalIncome =>
      transactions.where((t) => t.isIncome).fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses =>
      transactions.where((t) => !t.isIncome).fold(0.0, (sum, t) => sum + t.amount);

  double get balance => totalIncome - totalExpenses;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // ✅ Dummy data with categories
    transactions.addAll([
      TransactionModel(
        title: "Monthly Salary",
        amount: 2500,
        isIncome: true,
        date: "2025-10-01",
        category: "salary",
      ),
      TransactionModel(
        title: "Groceries at Walmart",
        amount: 120.5,
        isIncome: false,
        date: "2025-10-01",
        category: "groceries",
      ),
      TransactionModel(
        title: "Grab Ride",
        amount: 15,
        isIncome: false,
        date: "2025-09-30",
        category: "transport",
      ),
      TransactionModel(
        title: "Freelance Project",
        amount: 400,
        isIncome: true,
        date: "2025-09-29",
        category: "freelance",
      ),
      TransactionModel(
        title: "Netflix Subscription",
        amount: 13.99,
        isIncome: false,
        date: "2025-09-28",
        category: "entertainment",
      ),
      TransactionModel(
        title: "Dinner Out",
        amount: 45.75,
        isIncome: false,
        date: "2025-09-27",
        category: "food",
      ),
    ]);
  }
}
