import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF5ED),
      appBar: AppBar(title: const Text('Dashboard สรุปผล')),
      body: Consumer<CoffeeProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildStatCard('เมนูทั้งหมด', '${provider.totalMenus}', const Color(0xFF8D6E63), Icons.list_alt),
                const SizedBox(height: 15),
                _buildStatCard('พร้อมจำหน่าย', '${provider.readyToSell}', const Color(0xFF66BB6A), Icons.check_circle_outline),
                const SizedBox(height: 15),
                _buildStatCard('ราคาเฉลี่ยต่อแก้ว', '${provider.averagePrice.toStringAsFixed(2)} ฿', const Color(0xFFFFA726), Icons.payments_outlined),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            ],
          ),
          Icon(icon, color: Colors.white.withOpacity(0.4), size: 50),
        ],
      ),
    );
  }
}