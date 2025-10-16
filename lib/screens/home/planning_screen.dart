import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import 'planning_controller.dart';

class PlanningScreen extends StatelessWidget {
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlanningController controller = Get.put(PlanningController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🧾 Monthly Budget Card
              Obx(() {
                final spent = controller.spentAmount.value;
                final budget = controller.monthlyBudget.value;
                final remaining = (budget - spent).clamp(0, budget);
                final progress = (spent / budget).clamp(0.0, 1.0);

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Monthly Budget",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          "\$${spent.toStringAsFixed(2)} spent of \$${budget.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Remaining: \$${remaining.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // 🎯 Savings Goals Section
              Text("Savings Goals",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              Obx(() {
                return Column(
                  children: controller.goals.map((goal) {
                    final progress = (goal.saved / goal.target).clamp(0.0, 1.0);

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Circular glowing ring
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: CircularProgressIndicator(
                                    value: progress,
                                    strokeWidth: 8,
                                    backgroundColor: AppColors.border,
                                    valueColor:
                                    AlwaysStoppedAnimation(AppColors.primary),
                                  ),
                                ),
                                Text(
                                  "${(progress * 100).toStringAsFixed(0)}%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            // Goal info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(goal.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const SizedBox(height: 4),
                                  Text(
                                    "\$${goal.saved.toStringAsFixed(2)} / \$${goal.target.toStringAsFixed(2)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),

              // ➕ Add New Goal Button
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add New Goal"),
                  onPressed: () => _showAddGoalDialog(context, controller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context, PlanningController controller) {
    final nameController = TextEditingController();
    final targetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("New Goal"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Goal Name"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: targetController,
              decoration: const InputDecoration(labelText: "Target Amount"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  targetController.text.isNotEmpty) {
                controller.addGoal(
                  nameController.text,
                  double.tryParse(targetController.text) ?? 0.0,
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
