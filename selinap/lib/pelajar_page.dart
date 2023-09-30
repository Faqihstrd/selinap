//import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:selinap/const.dart';
import 'package:selinap/piket.dart';

class PelajarPage extends StatefulWidget {
  const PelajarPage({super.key});

  @override
  State<PelajarPage> createState() => _PelajarPageState();
}

class _PelajarPageState extends State<PelajarPage> {
  List<dynamic> data = [];

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

  void filterData(String query) {
    setState(() {
      data = data
          .where((item) => item['nama_pelajar']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Tambah Pelanggaran Siswa'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pencarian siswa',
              ),
              onSubmitted: (value) {
                filterData(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                          onPressed: () async {
                            await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return PiketDialog(
                                    idPel: data[index]['id_pelajar'],
                                  );
                                });
                            getData('');

                            // showDialog<void>(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return _alertDialogUpdate(data[index]);
                            //     });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.blue,
                          )),
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
