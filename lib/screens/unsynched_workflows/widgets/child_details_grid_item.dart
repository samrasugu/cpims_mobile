import 'package:flutter/material.dart';

class ChildDetailsGridItem extends StatelessWidget {
  const ChildDetailsGridItem({
    super.key, required this.header, required this.details,
  });

  final String header;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          details,
        )
      ],
    );
  }
}
