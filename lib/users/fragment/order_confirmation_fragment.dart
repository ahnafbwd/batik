// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Pesanan'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang di Bunds Bakery!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Pesanan Anda Sukses diCheck Out',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Selanjutnya Lakukan Pembayaran Via Transfer ke Rekening ',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'BRI : 014801118168504.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Segera Kirimkan Bukti Pembayaran anda ke Via Whatsapp di bawah ini',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Ager Pesenan Sampean Makle Esiap agi',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.orange,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Kirimkan Bukti Pembayaran Ke',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text(
                'Whatsapp',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              onPressed: () {
                String phoneNumber =
                      '6281333468527'; // Nomor telepon yang ingin Anda tuju
                  String message =
                      'Halo, dengan CS Bunda Catering? berikut bukti pembayarannya'; // Pesan yang ingin Anda kirim

                  final link = WhatsAppUnilink(
                    phoneNumber: phoneNumber,
                    text: message,
                  );

                  launch('$link');
              },
            ),
          ],
        ),
      ),
  );
  }
}
  