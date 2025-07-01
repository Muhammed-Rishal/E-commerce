import 'package:flutter/material.dart';

class SizeBox extends StatelessWidget {
  final String size;
  final String selectedSize;
  final Function(String) onSizeSelected;

  const SizeBox({
    super.key,
    required this.size,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () => onSizeSelected(size),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pinkAccent.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
