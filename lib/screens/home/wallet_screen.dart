import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/home/wallet_controller.dart';
import '../../theme/app_colors.dart';

class WalletsScreen extends StatelessWidget {
  const WalletsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletsController controller = Get.put(WalletsController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 💰 Total Balance Summary
              Obx(() {
                final total = controller.totalBalance.value;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  color: AppColors.card,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Balance",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // 🪙 Wallet Accounts
              Text("My Wallets",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              Obx(() {
                return Column(
                  children: controller.wallets.map((wallet) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      color: AppColors.card,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.15),
                          child: Icon(wallet.icon, color: AppColors.primary),
                        ),
                        title: Text(wallet.name,
                            style:
                            TextStyle(color: AppColors.textPrimary)),
                        subtitle: Text(wallet.type,
                            style:
                            TextStyle(color: AppColors.textSecondary)),
                        trailing: Text(
                          "\$${wallet.balance.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),

              const SizedBox(height: 24),

              // 💳 Loan & Debt Section
              Text("Loans / Debts",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              Obx(() {
                if (controller.loans.isEmpty) {
                  return Center(
                    child: Text(
                      "No loans or debts yet.",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  );
                }

                return Column(
                  children: controller.loans.map((loan) {
                    final remainingDays = loan.dueDate.difference(DateTime.now()).inDays;
                    final dueText = remainingDays >= 0
                        ? "$remainingDays days left"
                        : "Overdue ${remainingDays.abs()} days";

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 3,
                      color: AppColors.card,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.expense.withOpacity(0.15),
                          child: const Icon(Icons.trending_down, color: AppColors.expense),
                        ),
                        title: Text(loan.name,
                            style: TextStyle(color: AppColors.textPrimary)),
                        subtitle: Text(
                          "Due: ${loan.dueDate.toLocal().toString().split(' ')[0]} ($dueText)",
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        trailing: Text(
                          "-\$${loan.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: AppColors.expense,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),

              // ➕ Add Loan Button
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add Loan / Debt"),
                  onPressed: () => _showAddLoanDialog(context, controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddLoanDialog(BuildContext context, WalletsController controller) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    DateTime selectedDate = DateTime.now().add(const Duration(days: 30));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("New Loan / Debt"),
        content: StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text("Due: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    child: const Text("Change"),
                  ),
                ],
              ),
            ],
          );
        }),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  amountController.text.isNotEmpty) {
                controller.addLoan(
                  nameController.text,
                  double.tryParse(amountController.text) ?? 0.0,
                  selectedDate,
                );
                Get.back();
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
