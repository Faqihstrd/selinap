import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:new_selinap/const.dart';
import 'package:new_selinap/database/user_local.dart';

class PiketDialog extends StatefulWidget {
  const PiketDialog({super.key, required this.idPel});

  final String idPel;

  @override
  State<PiketDialog> createState() => _PiketDialogState();
}

class _PiketDialogState extends State<PiketDialog> {
  TextEditingController ctrlKeterangan = TextEditingController();
  TextEditingController ctrlJenisPel = TextEditingController();

  // Initial Selected Value
  Map<String, dynamic>? dropdownvalue;
  bool isLoading = true;
  int point = 0;
  final local = UserLocal();

  // List of items in our dropdown menu
  List items = [];

  @override
  void initState() {
    super.initState();
    getPelanggaran('');
  }

  // var  uri = Uri.parse('$BaseURL/pelanggaran/search.php');

  Future getPelanggaran(String search) async {
    http.Response response;
    var uri = Uri.parse('$BaseURL/pelanggaran/search.php');
    response = await http.post(uri, body: {
      "search": search,
    });
    if (response.statusCode == 200) {
      items = json.decode(response.body);
      isLoading = false;
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

  Future<void> addData() async {
    http.Response response;
    var uri = Uri.parse('$BaseURL/point/insert.php');
    var idGuru = local.getUser()!;
    if (dropdownvalue == null) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Jenis Pelanggaran harus diisi!',
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }
    response = await http.post(uri, body: {
      'id_pelajar': widget.idPel,
      'id_pelanggaran': dropdownvalue!['id_pelanggaran'],
      'poin_pelanggaran': dropdownvalue!['poin_pelanggaran'],
      'id_guru': idGuru['id_pengguna'],
      'keterangan': ctrlKeterangan.text,
    });
    var rest = json.decode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: rest['message'],
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: rest['message'],
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Data'),
      content: isLoading
          ? const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<Map<String, dynamic>>(
                    // Initial Value
                    value: dropdownvalue,
                    hint: const Text("Pilih Jenis Pelanggaran"),

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((dynamic item) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: item,
                        child: Text(item['nama_pelanggaran']),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (Map<String, dynamic>? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        point = int.tryParse(newValue['poin_pelanggaran']) ?? 0;
                      });
                    },
                  ),
                  TextField(
                    controller: ctrlKeterangan,
                    // keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Keterangan'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const Text("Point"), Text("$point"),
                  //   TextField(
                  //      controller: ctrlPoint,
                  // // keyboardType: TextInputType.number,
                  // decoration: const InputDecoration(
                  //   label: Text('Point Pelanggaran'),
                  // ),
                  // ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (_) => WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  backgroundColor: Colors.white.withOpacity(.5),
                  content: Container(
                    height: 300,
                    width: 300,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(
                        strokeWidth: 12,
                      ),
                    ),
                  ),
                ),
              ),
            );
            await addData();
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
