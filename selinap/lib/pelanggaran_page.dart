import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:selinap/const.dart';

class PelanggaranPage extends StatefulWidget {
  const PelanggaranPage({super.key});

  @override
  State<PelanggaranPage> createState() => _PelanggaranPageState();
}

class _PelanggaranPageState extends State<PelanggaranPage> {
  List data = [];

  @override
  void initState() {
    super.initState();
    getData('');
  }

  Future getData(String search) async {
    var response;
    var uri = Uri.parse('$BaseURL/pelanggaran/search.php');
    response = await http.post(uri, body: {
      "search": search,
    });
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  //MENAMBAHKAN DATA
  Future addData(
    String nama_pelanggaran,
    String deskripsi_pelanggaran,
    String poin_pelanggaran,
  ) async {
    // var uri = Uri.parse('$BaseURL/pelanggaran/insert.php');
    // var request = http.MultipartRequest("POST", uri);
    // request.fields['nama_pelanggaran'] = nama_pelanggaran;
    // request.fields['deskripsi_pelanggaran'] = deskripsi_pelanggaran;
    // request.fields['poin_pelanggaran'] = poin_pelanggaran;
    // var response = await request.send();

    var response;
    var uri = Uri.parse('$BaseURL/pelanggaran/insert.php');
    response = await http.post(uri, body: {
      "nama_pelanggaran": nama_pelanggaran,
      "deskripsi_pelanggaran": deskripsi_pelanggaran,
      "poin_pelanggaran": poin_pelanggaran,
    });

    if (response.statusCode == 200) {
      getData('');
      return Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Data Berhasil Ditambahkan',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  StatefulBuilder _alertDialog() {
    TextEditingController ctrlNama = TextEditingController();
    TextEditingController ctrlPelanggaran = TextEditingController();
    TextEditingController ctrlPoint = TextEditingController();
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text('Tambah Data'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrlNama,
                decoration: const InputDecoration(
                  label: Text('Nama Pelanggaran'),
                ),
              ),
              TextField(
                controller: ctrlPelanggaran,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Point Pelanggaran'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: ctrlPoint,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Point Pelanggaran'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addData(ctrlNama.text, ctrlPelanggaran.text, ctrlPoint.text);
              getData('');
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    });
  }

  Future deleteData(Int? id_pelanggaran) async {
    var response;
    var uri = Uri.parse('$BaseURL/pelanggaran/delete.php');
    response = await http.post(uri, body: {
      "id ": id_pelanggaran,
    });
    if (response.statusCode == 200) {
      getData('');
      return Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Data Berhasil Dihapus',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  AlertDialog _alertDialogDelete(Map<String, dynamic> data) {
    return AlertDialog(
      title: Text('Delete Data'),
      content: Text('Apakah anda ingin menghapus ${data['nama']}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            deleteData(data['id_pelanggaran ']);
            Navigator.of(context).pop();
          },
          child: const Text('Hapus'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return _alertDialog();
              });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Data Pelanggaran'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(data[index]['nama_pelanggaran'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(data[index]['deskripsi_pelanggaran']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      // showDialog<void>(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return _alertDialogUpdate(data[index]);
                      //     });
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return _alertDialogDelete(data[index]);
                          });
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
    );
  }
}
