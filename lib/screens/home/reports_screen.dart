import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'reports_controller.dart';
import '../../theme/app_colors.dart'; // assuming you already have your standardized colors

class ReportsScreen extends StatelessWidget {
  final ReportsController controller = Get.put(ReportsController());

  ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: "Categories"),
              Tab(text: "Trends"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCategoriesTab(),
            _buildTrendsTab(),
          ],
        ),
      ),
    );
  }

  // 🟢 Summary Tab
  Widget _buildSummaryTab() {
    return Center(
      child: Obx(() => Text(
        controller.biggestExpense,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      )),
    );
  }

  // 🟣 Categories Tab → Pie Chart
  Widget _buildCategoriesTab() {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: controller.categories.map((data) {
                  final total = controller.categories.fold<double>(
                      0, (sum, item) => sum + item.amount);
                  final percentage = (data.amount / total) * 100;
                  return PieChartSectionData(
                    color: data.color,
                    value: data.amount,
                    title: "${percentage.toStringAsFixed(1)}%",
                    radius: 70,
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 50,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            children: controller.categories.map((cat) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 6, backgroundColor: cat.color),
                  const SizedBox(width: 6),
                  Text(cat.name),
                ],
              );
            }).toList(),
          )
        ],
      ),
    ));
  }

  // 🟡 Trends Tab → Bar Chart
  Widget _buildTrendsTab() {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index < 0 || index >= controller.monthlyExpenses.length) {
                    return const SizedBox();
                  }
                  return Text(controller.monthlyExpenses[index].month);
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: controller.monthlyExpenses.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data.amount,
                  width: 20,
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.primary,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    ));
  }
}
