
import 'package:flutter/material.dart';
 
class CategoryTag extends StatelessWidget {
  final String kategori;
 
  const CategoryTag({super.key, required this.kategori});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        kategori,
        style: TextStyle(fontSize: 11, color: Colors.blueGrey.shade700),
      ),
    );
  }
}
 