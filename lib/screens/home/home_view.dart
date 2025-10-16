import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/home/planning_screen.dart';
import 'package:untitled/screens/home/reports_screen.dart';
import 'package:untitled/screens/home/wallet_screen.dart';
import '../../component/bottom_nav_bar.dart';
import '../../theme/app_colors.dart';
import 'home_controller.dart';
import 'transaction_screen.dart';
import 'reports_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final List<Widget> screens = [
      TransactionScreen(),
      PlanningScreen(),
      WalletsScreen(),
      ReportsScreen(),
    ];

    return Obx(() => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "ZC",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'settings') {
                Get.snackbar("Settings", "Opening settings...");
              } else if (value == 'logout') {
                Get.snackbar("Logout", "You have been logged out.");
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, size: 20),
                      SizedBox(width: 8),
                      Text("Settings"),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20),
                      SizedBox(width: 8),
                      Text("Logout"),
                    ],
                  ),
                ),
              ];
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: screens[controller.selectedIndex.value],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        onPressed: () => _showAddTransactionDialog(context, controller),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: controller.selectedIndex.value,
        onItemTapped: controller.changeTab,
      ),
    ));
  }
}
void _showAddTransactionDialog(
    BuildContext context, HomeController controller) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  final RxString type = "Income".obs;
  final RxString category = "Food".obs;

  final List<String> categories = [
    "Food",
    "Transport",
    "Shopping",
    "Bills",
    "Salary",
    "Others"
  ];

  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🔘 Income / Expense Toggle
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text("Income"),
                    selected: type.value == "Income",
                    selectedColor: AppColors.income.withOpacity(0.2),
                    onSelected: (selected) {
                      if (selected) type.value = "Income";
                    },
                    labelStyle: TextStyle(
                      color: type.value == "Income"
                          ? AppColors.income
                          : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text("Expense"),
                    selected: type.value == "Expense",
                    selectedColor: AppColors.expense.withOpacity(0.2),
                    onSelected: (selected) {
                      if (selected) type.value = "Expense";
                    },
                    labelStyle: TextStyle(
                      color: type.value == "Expense"
                          ? AppColors.expense
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 16),

              // 🏷 Category Dropdown
              Obx(() => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                value: category.value,
                items: categories
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                onChanged: (value) => category.value = value ?? "Others",
              )),
              const SizedBox(height: 16),

              // 🧾 Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Transaction Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // 💰 Amount
              TextField(
                controller: amountController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // 🗒 Remark
              TextField(
                controller: remarkController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Remark (optional)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final name = nameController.text.trim();
                      final amount =
                          double.tryParse(amountController.text) ?? 0.0;

                      if (name.isEmpty || amount <= 0) {
                        Get.snackbar("Error", "Please fill all fields properly");
                        return;
                      }

                      Get.snackbar(
                        "Added",
                        "${type.value} transaction added successfully!",
                        snackPosition: SnackPosition.BOTTOM,
                      );

                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
