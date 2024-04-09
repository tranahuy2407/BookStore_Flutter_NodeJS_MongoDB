import 'package:flutter/material.dart';

class CartSubtotal extends StatelessWidget {
  final double initialTotal;
  final double discountedTotal;

  const CartSubtotal({
    Key? key,
    required this.initialTotal,
    required this.discountedTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Tổng cộng ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          if (discountedTotal != 0) // Hiển thị discountedTotal nếu nó khác 0
            Text(
              '${discountedTotal.toStringAsFixed(2)} VNĐ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (discountedTotal == 0) // Hiển thị initialTotal nếu discountedTotal là 0
            Text(
              '${initialTotal.toStringAsFixed(2)} VNĐ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
