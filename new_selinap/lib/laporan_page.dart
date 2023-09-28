import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:new_selinap/const.dart';
import 'package:new_selinap/model/laporan_model.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  List<LaporanModel> data = [];

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
    var uri = Uri.parse('$BaseURL/point/laporan.php');
    response = await http.get(uri);
    if (response.statusCode == 200) {
      List decode = json.decode(response.body);
      data = decode.map((e) => LaporanModel.fromMap(e)).toList();
      setState(() {});
    } else {
      return Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Something went wrong ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

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
        title: const Text('Laporan Terbaru'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          // return Row(
          //   children: [
          //     Text(
          //       "${index + 1}. ${data[index].namaPelajar}/${data[index].namaPelanggaran}",
          //       style: const TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // );
          return ListTile(
            leading: Text("${index + 1}."),
            minLeadingWidth: 20,
            title: Text(
              data[index].namaPelajar ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data[index].namaPelanggaran ?? ''),
                Text(DateFormat("dd MMMM yyyy hh:mm").format(
                    DateTime.parse(data[index].tanggalPelanggaran ?? ''))),
              ],
            ),
            trailing: Text(data[index].poinPelanggaran ?? ''),
          );
        },
      ),
    );
  }
}
