import 'package:flutter/material.dart';

void main() {
  runApp(const DriverApp());
}

class DriverApp extends StatelessWidget {
  const DriverApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ojek Online Driver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DriverScreen(),
    );
  }
}

class DriverScreen extends StatefulWidget {
  const DriverScreen({Key? key}) : super(key: key);

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  // Simulasi daftar order masuk dari customer
  final List<Map<String, String>> _incomingOrders = [
    {
      'orderId': '1786884424687',
      'pickup': 'Stasiun Tulungagung',
      'destination': 'Alun-Alun Tulungagung'
    }
  ];

  void _terimaOrder(String orderId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order $orderId diterima! Menuju lokasi jemput...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard - Cari Order'),
      ),
      body: _incomingOrders.isEmpty
          ? const Center(child: Text('Belum ada pesanan masuk.'))
          : ListView.builder(
              itemCount: _incomingOrders.length,
              itemBuilder: (context, index) {
                final order = _incomingOrders[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.motorcycle, color: Colors.blue, size: 40),
                    title: Text('Jemput: ${order['pickup']}'),
                    subtitle: Text('Tujuan: ${order['destination']}'),
                    trailing: ElevatedButton(
                      onPressed: () => _terimaOrder(order['orderId']!),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text('Ambil', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
