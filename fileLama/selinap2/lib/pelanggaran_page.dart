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

  TextEditingController ctrlNama = TextEditingController();
  TextEditingController ctrlDescPelanggaran = TextEditingController();
  TextEditingController ctrlPoint = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData('');
  }

  Future getData(String search) async {
    http.Response response;
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
  // Future addData(
  //   String nama_pelanggaran,
  //   String deskripsi_pelanggaran,
  //   String poin_pelanggaran,
  // ) async {
  //   var uri = Uri.parse('$BaseURL/pelanggaran/insert.php');
  //   var request = http.MultipartRequest("POST", uri);
  //   request.fields['nama_pelanggaran'] = nama_pelanggaran;
  //   request.fields['deskripsi_pelanggaran'] = deskripsi_pelanggaran;
  //   request.fields['poin_pelanggaran'] = poin_pelanggaran;
  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     getData('');
  //     return Fluttertoast.showToast(
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       msg: 'Data Berhasil Ditambahkan',
  //       toastLength: Toast.LENGTH_SHORT,
  //     );
  //   } else {
  //     return Fluttertoast.showToast(
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       msg: 'Something went wrong ${response.statusCode}',
  //       toastLength: Toast.LENGTH_SHORT,
  //     );
  //   }
  // }

  Future addData() async {
    // var uri = Uri.parse('$BaseURL/pelanggaran/insert.php');
    String phpurl = "$BaseURL/pelanggaran/insert.php";
    var res = await http.post(Uri.parse(phpurl), body: {
      "nama_pelanggaran": ctrlNama.text,
      "deskirpsi_pelanggaran": ctrlDescPelanggaran.text,
      "poin_pelanggaran": ctrlPoint.text,
    });

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          //    sending = false;
          //     error = true;
          //     msg = data["message"]; //error message from server
        });
      } else {
        return Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Data Berhasil Ditambahkan',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${res.statusCode}',
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
        title: const Text('Tambah Data'),
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
                  label: Text('Deskripsi Pelanggaran'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: ctrlPoint,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Point Pelanggaran'),
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
              addData();
              getData('');
              Navigator.of(context).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    });
  }

  Future deleteData(Int? idPelanggaran) async {
    http.Response response;
    var uri = Uri.parse('$BaseURL/pelanggaran/delete.php');
    response = await http.post(uri, body: {
      "id ": idPelanggaran,
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
        child: const Icon(Icons.add),
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
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return _alertDialogDelete(data[index]);
                          });
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
    );
  }
}
