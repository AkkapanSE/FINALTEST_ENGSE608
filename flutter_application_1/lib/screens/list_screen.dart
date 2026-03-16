import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coffee_provider.dart';
import 'form_screen.dart'; 
import 'dashboard_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CoffeeProvider>(context, listen: false).fetchAndSetCoffee());
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF5ED),
      appBar: AppBar(
        title: const Text('☕ Coffee Menu', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen())),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาเมนูโปรดของคุณ...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF6F4E37)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
        ),
      ),
      body: Consumer<CoffeeProvider>(
        builder: (context, provider, child) {
          final filteredItems = provider.items.where((item) =>
              item.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();

          if (filteredItems.isEmpty) {
            return const Center(child: Text('ยังไม่มีเมนูกาแฟในรายการ'));
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 80),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFF6F4E37).withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.coffee_maker, color: Color(0xFF6F4E37)),
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreen(coffee: item))),
                  title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          _buildTag(item.type, Colors.brown),
                          const SizedBox(width: 5),
                          _buildTag(item.status, item.status == 'พร้อมขาย' ? Colors.green : Colors.red),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('ราคา ${item.price} บาท', style: const TextStyle(color: Color(0xFF6F4E37), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('ยืนยันการลบ'),
                          content: Text('ต้องการลบเมนู ${item.name} หรือไม่?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ยกเลิก')),
                            TextButton(
                              onPressed: () {
                                provider.deleteCoffee(item.id!);
                                Navigator.pop(ctx);
                              }, 
                              child: const Text('ลบ', style: TextStyle(color: Colors.red))
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF6F4E37),
        foregroundColor: Colors.white,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreen())),
        label: const Text('เพิ่มเมนู'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}