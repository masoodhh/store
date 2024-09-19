import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTitle(),
        _buildSearchBar(),
      ],
    );
  }
}
Widget _buildTitle() {
  return const Text(
    "Daily \nGrocery Food",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xff1e1f22),
      fontSize: 40,
    ),
    softWrap: true,
  );
}

Widget _buildSearchBar() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 1, color: Colors.black12),
    ),
    padding: const EdgeInsets.all(10),
    height: 80,
    child: const Icon(
      Icons.search,
      color: Color(0xFF18263E),
      size: 40,
    ),
  );
}