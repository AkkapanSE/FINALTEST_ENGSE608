import 'package:flutter/material.dart';
import '../models/coffee_model.dart';

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const CoffeeCard({
    required this.coffee,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        onTap: onTap,
        title: Text(coffee.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${coffee.type} | ราคา ${coffee.price} บาท\nสถานะ: ${coffee.status}'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}