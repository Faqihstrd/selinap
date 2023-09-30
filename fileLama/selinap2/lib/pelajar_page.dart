import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:selinap/const.dart';

class PelajarPage extends StatefulWidget {
  const PelajarPage({super.key});

  @override
  State<PelajarPage> createState() => _PelajarPageState();
}

class _PelajarPageState extends State<PelajarPage> {
  List data = [];

  @override
  void initState() {
    super.initState();
    getData('');
  }

  Future getData(String search) async {
    http.Response response;
    var uri = Uri.parse('$BaseURL/pelajar/search.php');
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
    String namaPelajar,
    String deskripsiPelajar,
    String poinPelajar,
  ) async {
    var uri = Uri.parse('$BaseURL/pelajar/insert.php');
    var request = http.MultipartRequest("POST", uri);
    request.fields['nama_pelajar'] = namaPelajar;
    request.fields['deskripsi_pelajar'] = deskripsiPelajar;
    request.fields['poin_pelajar'] = poinPelajar;
    var response = await request.send();

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
    TextEditingController ctrlpelajar = TextEditingController();
    TextEditingController ctrlPoint = TextEditingController();
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Tambah Data'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrlNama,
                decoration: const InputDecoration(
                  label: Text('Nama pelajar'),
                ),
              ),
              TextField(
                controller: ctrlpelajar,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Point pelajar'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ctrlPoint,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Point pelajar'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addData(ctrlNama.text, ctrlpelajar.text, ctrlPoint.text);
              getData('');
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    });
  }

  Future deleteData(Int? idPelajar) async {
    http.Response response;
    var uri = Uri.parse('$BaseURL/pelajar/delete.php');
    response = await http.post(uri, body: {
      "id ": idPelajar,
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
      title: const Text('Delete Data'),
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
            deleteData(data['id_pelajar ']);
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
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Data pelajar'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(data[index]['nis_pelajar'],
                style: const TextStyle(
                  fontSize: 12,
                )),
            title: Text(data[index]['nama_pelajar']),
            subtitle: Text(data[index]['poin_pelajar'],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                )),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                    //  showDialog<void>(
                     //     context: context,
             //             builder: (BuildContext context) {
                         //   return PiketDialog();
                //          });

                      // showDialog<void>(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return _alertDialogUpdate(data[index]);
                      //     });
                    },
                    icon: const Icon(Icons.select_all)),
              ],
            ),
          );
        },
      ),
    );
  }
}
