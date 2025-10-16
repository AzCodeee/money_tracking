import 'package:get/get.dart';

class Goal {
  String name;
  double target;
  double saved;

  Goal({required this.name, required this.target, this.saved = 0});
}

class PlanningController extends GetxController {
  var monthlyBudget = 2000.0.obs;
  var spentAmount = 820.0.obs;

  var goals = <Goal>[].obs;

  void addGoal(String name, double target) {
    goals.add(Goal(name: name, target: target, saved: 0));
  }
}
