import 'package:flutter/material.dart';


class AboutFragment extends StatelessWidget {
  // final String whatsappNumber = '087735377011'; // Ganti dengan nomor WhatsApp yang diinginkan

  // void openWhatsAppChat() async {
  //   final url = 'https://wa.me/$whatsappNumber';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
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
              'Kami adalah toko Bunds Bakery yang khusus berfokus pada penjualan dan Pemesanan catering makanan dan Roti. Dengan dedikasi kami untuk menyediakan produk dan bahan terbaik, kami berupaya memenuhi kebutuhan Anda dalam mendapatkan makanan yang berkualitas.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Di Bunds Bakery, Anda akan menemukan beragam jajanan dan roti yang berkualitas, Jajan naisional, Roti, Donat, dan banyak lagi. Kami menyediakan berbagai ketrinngan siap kirim ke rumah dan harga yang terjangkau.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Ayo jelajahi koleksi kami dan temukan baranag yang kamu pengenin di Bunds Bakery.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Jika sampean mengalami kesulitan toreh hubungi kami dengan cara klik icon dibawah ini!!!.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Memanggil fungsi untuk membuka WhatsApp
        },
        child: Icon(Icons.chat_sharp),
        backgroundColor: Color(0xFF25D366),
      ),
  );
  }
}