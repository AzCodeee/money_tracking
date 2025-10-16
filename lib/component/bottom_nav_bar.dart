import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home,
                  color: selectedIndex == 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color),
              onPressed: () => onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.bar_chart,
                  color: selectedIndex == 1
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color),
              onPressed: () => onItemTapped(1),
            ),
            const SizedBox(width: 40), // space for FAB
            IconButton(
              icon: Icon(Icons.account_balance_wallet,
                  color: selectedIndex == 2
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color),
              onPressed: () => onItemTapped(2),
            ),
            IconButton(
              icon: Icon(Icons.analytics,
                  color: selectedIndex == 3
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).iconTheme.color),
              onPressed: () => onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
