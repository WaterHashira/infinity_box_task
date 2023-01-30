import 'package:flutter/material.dart';

//TODO: put the push replacements routes here to its buttons

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
              icon: const Icon(
                Icons.book,
                color: Colors.white,
              ),
              onPressed: () {}),
          activeIcon: const Icon(
            Icons.book,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ),
              onPressed: () {}),
          activeIcon: const Icon(
            Icons.history,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
              icon: const Icon(
                Icons.payment,
                color: Colors.white,
              ),
              onPressed: () {}),
          activeIcon: const Icon(
            Icons.payment,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
