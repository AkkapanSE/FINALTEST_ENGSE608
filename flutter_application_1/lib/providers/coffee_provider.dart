import 'package:flutter/material.dart';
import '../models/coffee_model.dart';
import '../services/database_helper.dart';

class CoffeeProvider with ChangeNotifier {
  List<Coffee> _items = [];
  
  List<Coffee> get items => _items;

  // โหลดข้อมูลจาก DB มาเก็บไว้ในเครื่อง
  Future<void> fetchAndSetCoffee() async {
    _items = await DatabaseHelper.instance.getAllCoffee();
    notifyListeners(); // บอกให้หน้าจอรู้ว่าข้อมูลเปลี่ยนแล้วนะ
  }

  // เพิ่มเมนู
  Future<void> addCoffee(Coffee coffee) async {
    await DatabaseHelper.instance.insertCoffee(coffee);
    await fetchAndSetCoffee();
  }

  // แก้ไขเมนู
  Future<void> updateCoffee(Coffee coffee) async {
    await DatabaseHelper.instance.updateCoffee(coffee);
    await fetchAndSetCoffee();
  }

  // ลบเมนู
  Future<void> deleteCoffee(int id) async {
    await DatabaseHelper.instance.deleteCoffee(id);
    await fetchAndSetCoffee();
  }

  // --- ส่วนของ Dashboard (โจทย์สั่งให้แสดงสรุปผล) ---
  int get totalMenus => _items.length;
  int get readyToSell => _items.where((e) => e.status == 'พร้อมขาย').length;
  double get averagePrice => _items.isEmpty 
      ? 0.0 
      : _items.map((e) => e.price).reduce((a, b) => a + b) / _items.length;
}