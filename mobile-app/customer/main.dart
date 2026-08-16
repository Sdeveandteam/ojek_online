import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(home: OrderScreen()));

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _pickupController = TextEditingController();
  final _destController = TextEditingController();

  // Ganti IP ini dengan IP lokal WiFi-mu (cek pakai perintah 'ifconfig' di Termux)
  // Contoh: http://192.168.1.5:3000/api/order
  final String apiUrl = "http://10.0.2.2:3000/api/order"; 

  Future<void> _pesanOjek() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "customerId": "12345",
        "pickup": _pickupController.text,
        "destination": _destController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order berhasil dikirim!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gagal kirim order')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesan Ojek')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _pickupController, decoration: const InputDecoration(labelText: 'Jemput')),
            TextField(controller: _destController, decoration: const InputDecoration(labelText: 'Tujuan')),
            ElevatedButton(onPressed: _pesanOjek, child: const Text('Pesan Sekarang')),
          ],
        ),
      ),
    );
  }
}
