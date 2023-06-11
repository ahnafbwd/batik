// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:batik/users/fragment/dashboard_fragment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:batik/users/userPreferences/current_user.dart';

class ProductDetailPage extends StatefulWidget {
  final String gambar;
  final String nama_barang;
  final String harga;
  final String keterangan;
  final int id;

  const ProductDetailPage({
    Key? key,
    required this.gambar,
    required this.nama_barang,
    required this.harga,
    required this.keterangan,
    required this.id,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  DateTime? selectedDate;
  int quantity = 1; // Jumlah awal produk yang dipesan
  String note = '';
  String userid = '';

  final TextEditingController _textEditingControllercatatan =
      TextEditingController();
  void showSuccessNotification() {
    Fluttertoast.showToast(
      msg: 'Produk berhasil ditambahkan ke keranjang',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  void showErrorNotification() {
    Fluttertoast.showToast(
      msg: 'Gagal menambahkan produk ke keranjang',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void updateNoteValue(String value) {
    setState(() {
      note = value;
    });
  }

  String calculateTotalPrice() {
    double harga = double.parse(widget.harga);
    double totalHarga = harga * quantity;
    String total = totalHarga.toString();
    return total;
  }

  Future<void> addToCart() async {
    final CurrentUser currentUser = Get.put(CurrentUser());
    userid = currentUser.user.user_id.toString();
    if (selectedDate != null) {
      print('Catatan : $note');
      print('Selected Date: $selectedDate');
      print('Quantity: $quantity');
      var url =
          'https://battiikk.000webhostapp.com/API/keranjang/masukkeranjang.php'; // Ganti dengan URL API PHP yang sesuai
      var totalHarga = calculateTotalPrice();
      var data = {
        'user_id': userid,
        'id': widget.id.toString(),
        'nama_barang': widget.nama_barang,
        'keterangan': widget.keterangan,
        'harga': widget.harga.toString(),
        'jumlah': quantity.toString(),
        'tanggal_booking':
            '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
        'total_harga': totalHarga,
        'catatan': note,
      };

      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          print('Data berhasil dikirim');
          showSuccessNotification();
        } else {
          print('Gagal mengirim data: ${responseData['message']}');
          showErrorNotification();
        }
      } else {
        print('Error: ${response.statusCode}');
      }
      // Tambahkan logika untuk menambahkan produk ke keranjang dengan jadwal dan jumlah produk yang dipilih
      // ...
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Peringatan'),
            content: const Text('Pilih jadwal pengantaran terlebih dahulu'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            widget.gambar,
            fit: BoxFit.cover,
            height: 400,
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(44.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      widget.nama_barang,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.harga,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Deskripsi Produk',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              widget.keterangan,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.date_range,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Hari Pengantaran',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Pilih Hari',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            selectedDate != null
                                ? Text(
                                    'Tanggal yang di butuhkan: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[700],
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Rincian Pengantaran',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Icon(
                                  Icons.delivery_dining,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  'Akan Di antar Pada:',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            selectedDate != null
                                ? Text(
                                    'Jadwal Pengantaran: ${selectedDate?.day ?? '-'}-${selectedDate?.month ?? '-'}-${selectedDate?.year ?? '-'}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[700],
                                    ),
                                  )
                                : const Text(
                                    'Jadwal Pengantaran belum terpilih',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.red,
                                    ),
                                  ),
                            const SizedBox(height: 8.0),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Jumlah',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: decrementQuantity,
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: incrementQuantity,
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Catatan',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                TextFormField(
                                  controller: _textEditingControllercatatan,
                                  decoration: const InputDecoration(
                                    hintText: 'Tambahkan Catatan...',
                                    fillColor: Colors.grey,
                                    focusColor: Colors.black,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orangeAccent),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    updateNoteValue(value);
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              onPressed: () {
                                if (selectedDate != null) {
                                  print('catatan : $note');
                                  print('Selected Date: $selectedDate');
                                  print('Quantity: $quantity');
                                  addToCart().then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardFragment()));
                                  });
                                  // Tambahkan logika untuk menambahkan produk ke keranjang dengan jadwal dan jumlah produk yang dipilih
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Peringatan'),
                                        content: const Text(
                                            'Pilih jadwal pengantaran terlebih dahulu'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.orangeAccent,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Tambahkan ke Keranjang'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
