class TransactionModel {
  final String title;
  final double amount;
  final bool isIncome;
  final String date;
  final String category;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.isIncome,
    required this.date,
    required this.category,
  });
}
