import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../component/custom_icons.dart';

import '../../theme/app_colors.dart';
import 'home_controller.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return SafeArea(
      child: Column(
        children: [
          // ✅ Summary Card
          Obx(() => Card(
            margin: const EdgeInsets.all(16),
            elevation: 2,
            color: AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Balance",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      )),
                  const SizedBox(height: 8),
                  Text("\$${controller.balance.toStringAsFixed(2)}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      )),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Income",
                              style: TextStyle(
                                  color: AppColors.income,
                                  fontWeight: FontWeight.w500)),
                          Text(
                              "\$${controller.totalIncome.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Expenses",
                              style: TextStyle(
                                  color: AppColors.expense,
                                  fontWeight: FontWeight.w500)),
                          Text(
                              "\$${controller.totalExpenses.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),

          // ✅ Transaction List with Slidable
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: controller.transactions.length,
              itemBuilder: (context, index) {
                final transaction = controller.transactions[index];
                final isIncome = transaction.isIncome;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Slidable(
                    key: ValueKey(transaction.title + transaction.date),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.45,
                      children: [
                        SlidableAction(
                          onPressed: (_) =>
                              _showViewDialog(context, transaction),
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          icon: Icons.visibility,
                          label: 'View',
                        ),
                        SlidableAction(
                          onPressed: (_) => _showEditDialog(
                              context, controller, transaction),
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                      ],
                    ),
                    child: ListTile(
                      tileColor: AppColors.card,
                      leading: CircleAvatar(
                        backgroundColor: isIncome
                            ? AppColors.income
                            : AppColors.expense,
                        child: Icon(
                          CategoryIcons.getIcon(transaction.category),
                          color: Colors.white,
                        ),
                      ),
                      title: Text(transaction.title,
                          style: TextStyle(color: AppColors.textPrimary)),
                      subtitle: Text(transaction.date,
                          style: TextStyle(color: AppColors.textSecondary)),
                      trailing: Text(
                        (isIncome ? "+ " : "- ") +
                            "\$${transaction.amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: isIncome
                              ? AppColors.income
                              : AppColors.expense,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  // 🧾 Center Floating Modal (View)
  void _showViewDialog(BuildContext context, transaction) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.receipt_long, size: 48, color: AppColors.primary),
              const SizedBox(height: 12),
              Text("Transaction Details",
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text("Title: ${transaction.title}",
                  style: TextStyle(color: AppColors.textSecondary)),
              Text("Amount: \$${transaction.amount.toStringAsFixed(2)}",
                  style: TextStyle(color: AppColors.textSecondary)),
              Text("Date: ${transaction.date}",
                  style: TextStyle(color: AppColors.textSecondary)),
              Text("Type: ${transaction.isIncome ? "Income" : "Expense"}",
                  style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✏️ Center Floating Modal (Edit)
  void _showEditDialog(
      BuildContext context, HomeController controller, transaction) {
    final titleController = TextEditingController(text: transaction.title);
    final amountController =
    TextEditingController(text: transaction.amount.toString());

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_note, size: 48, color: AppColors.primary),
              const SizedBox(height: 12),
              Text("Edit Transaction",
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel", style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      transaction.title = titleController.text;
                      transaction.amount =
                          double.tryParse(amountController.text) ??
                              transaction.amount;
                      controller.transactions.refresh();
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
    );
  }
}
