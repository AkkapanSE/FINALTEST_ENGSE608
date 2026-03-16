import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_model.dart';
import '../providers/coffee_provider.dart';

class FormScreen extends StatefulWidget {
  final Coffee? coffee; // ถ้ามีข้อมูลส่งมาแสดงว่าเป็นโหมดแก้ไข

  FormScreen({this.coffee});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // สร้างตัวแปรเก็บค่าจากฟอร์ม
  late String _name;
  late String _type;
  late int _sweetness;
  late double _price;
  late String _status;
  String? _note;

  // ตัวเลือกสำหรับ Dropdown ตามโจทย์
  final List<String> _types = ['ร้อน', 'เย็น', 'ปั่น'];
  final List<String> _statuses = ['พร้อมขาย', 'หมด'];

  @override
  void initState() {
    super.initState();
    // ถ้าเป็นการแก้ไข ให้ดึงค่าเก่ามาใส่ไว้ก่อน
    _name = widget.coffee?.name ?? '';
    _type = widget.coffee?.type ?? 'ร้อน';
    _sweetness = widget.coffee?.sweetness ?? 100;
    _price = widget.coffee?.price ?? 0.0;
    _status = widget.coffee?.status ?? 'พร้อมขาย';
    _note = widget.coffee?.note ?? '';
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final newCoffee = Coffee(
        id: widget.coffee?.id,
        name: _name,
        type: _type,
        sweetness: _sweetness,
        price: _price,
        status: _status,
        note: _note,
      );

      if (widget.coffee == null) {
        Provider.of<CoffeeProvider>(context, listen: false).addCoffee(newCoffee);
      } else {
        Provider.of<CoffeeProvider>(context, listen: false).updateCoffee(newCoffee);
      }

      // แสดง SnackBar แจ้งเตือนเมื่อบันทึกสำเร็จ (โจทย์บังคับ)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('บันทึกข้อมูลสำเร็จแล้ว')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.coffee == null ? 'เพิ่มเมนูใหม่' : 'แก้ไขเมนู')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'ชื่อเมนู'),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกชื่อเมนู' : null,
                onSaved: (value) => _name = value!,
              ),
              DropdownButtonFormField(
                value: _type,
                decoration: InputDecoration(labelText: 'ประเภท'),
                items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                onChanged: (value) => setState(() => _type = value as String),
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'ราคา (บาท)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'กรุณากรอกราคา' : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('ระดับความหวาน: $_sweetness%'),
              ),
              Slider(
                value: _sweetness.toDouble(),
                min: 0, max: 100, divisions: 4,
                label: _sweetness.toString(),
                onChanged: (value) => setState(() => _sweetness = value.toInt()),
              ),
              DropdownButtonFormField(
                value: _status,
                decoration: InputDecoration(labelText: 'สถานะเมนู'),
                items: _statuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (value) => setState(() => _status = value as String),
              ),
              TextFormField(
                initialValue: _note,
                decoration: InputDecoration(labelText: 'หมายเหตุ (ถ้ามี)'),
                onSaved: (value) => _note = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('บันทึกข้อมูล'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}