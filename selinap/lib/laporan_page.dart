import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:selinap/const.dart';
import 'package:selinap/model/laporan_model.dart';
import 'package:selinap/print.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  List<dynamic> data = [];

  // TextEditingController ctrlNama = TextEditingController();
  // TextEditingController ctrlDescPelanggaran = TextEditingController();
  // TextEditingController ctrlPoint = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData('');
  }

  Future getData(String search) async {
    http.Response response;
    var uri = Uri.parse('$BaseURL/point/laporan.php');
    response = await http.post(uri, body: {
      "search": search,
    });
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

  // void filterData(String query) {
  //   setState(() {
  //     data = data
  //         .where((item) => item.namaPelajar
  //             .toString()
  //             .toLowerCase()
  //             .contains(query.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Pelanggaran Terbaru'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Pencarian siswa',
              ),
              onSubmitted: (value) {
                getData(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
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
                          DateTime.parse(
                              data[index].tanggalPelanggaran ?? ''))),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(data[index].poinPelanggaran ?? ''),
                      TextButton.icon(
                        onPressed: () {
                          // Get.to(PrintBt(data[index].namaPelajar ?? ""));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrintBt(data[index]),
                              ));
                        },
                        icon: const Icon(Icons.print),
                        label: const Text(''),
                        style: TextButton.styleFrom(
                          iconColor: Colors.blue,
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          backgroundColor: Colors.white10,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
