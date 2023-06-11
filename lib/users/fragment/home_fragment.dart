import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:batik/users/fragment/detail_fragment.dart';

void main() => runApp(AppBar());

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeFragment> {
  late Future<List<Map<String, dynamic>>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      Dio dio = Dio();
      Response response =
          await dio.get('https://battiikk.000webhostapp.com/api/home');
      if (response.statusCode == 200) {
        final jsonData = response.data['data'];
        return List<Map<String, dynamic>>.from(jsonData);
      } else {
        print('Request failed with status code: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: AlignmentDirectional.centerStart,
            color: Colors.orange,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    'Bunda Catering',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final data = snapshot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = data[index];
                        final id = item['id'];
                        final gambar =
                            'https://battiikk.000webhostapp.com/img/produck/${item['gambar']}';
                        final namaBarang = item['nama_barang'];
                        final harga = item['harga'];
                        final keterangan = item['keterangan'];
                        return Container(
                          padding: const EdgeInsets.all(
                              10.0), // Menambahkan jarak 10.0 pada semua sisi
                          child: GridTile(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Image.network(
                                      'https://battiikk.000webhostapp.com/img/produck/${item['gambar']}',
                                      height: 170,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(item['nama_barang']),
                                    Text('Rp ${item['harga']}'),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                        id: id,
                                        nama_barang: namaBarang,
                                        gambar: gambar,
                                        harga: harga,
                                        keterangan: keterangan,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}
