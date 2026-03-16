class Coffee {
  int? id;
  String name;
  String type;      // เช่น ร้อน, เย็น, ปั่น
  int sweetness;    // 0, 25, 50, 100
  double price;
  String status;    // พร้อมขาย, หมด
  String? note;

  Coffee({
    this.id,
    required this.name,
    required this.type,
    required this.sweetness,
    required this.price,
    required this.status,
    this.note,
  });

  // แปลงข้อมูลจาก Object เป็น Map เพื่อเก็บใน Database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'sweetness': sweetness,
      'price': price,
      'status': status,
      'note': note,
    };
  }

  // แปลงข้อมูลจาก Database (Map) กลับมาเป็น Object
  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      sweetness: map['sweetness'],
      price: map['price'],
      status: map['status'],
      note: map['note'],
    );
  }
}