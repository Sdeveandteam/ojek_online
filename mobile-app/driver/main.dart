import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(home: DriverScreen()));

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});
  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  List _incomingOrders = [];
  
  // Gunakan IP 10.0.2.2 untuk emulator, atau IP lokal PC jika di HP fisik
  final String fetchUrl = "http://10.0.2.2:3000/api/orders";
  final String acceptUrl = "http://10.0.2.2:3000/api/accept-order";

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  // Ambil daftar pesanan dari backend
  Future<void> _fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(fetchUrl));
      if (response.statusCode == 200) {
        setState(() {
          _incomingOrders = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  // Terima pesanan tertentu
  Future<void> _terimaOrder(String orderId) async {
    final response = await http.post(
      Uri.parse(acceptUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"orderId": orderId, "driverId": "driver_999"}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order berhasil diambil!')),
      );
      _fetchOrders(); // Refresh daftar order
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil order')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Driver'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _fetchOrders)
        ],
      ),
      body: _incomingOrders.isEmpty
          ? const Center(child: Text("Belum ada pesanan masuk."))
          : ListView.builder(
              itemCount: _incomingOrders.length,
              itemBuilder: (context, index) {
                final order = _incomingOrders[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.motorcycle, color: Colors.blue, size: 40),
                    title: Text("Jemput: ${order["pickup"]}"),
                    subtitle: Text("Tujuan: ${order["destination"]}"),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () => _terimaOrder(order["orderId"]),
                      child: const Text("Ambil", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
