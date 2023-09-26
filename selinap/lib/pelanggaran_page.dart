import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showDialog<void>(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return _alertDialog();
            //     });
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
                        // showDialog<void>(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return _alertDialogDelete(data[index]);
                        //     });
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            );
          },
        ));
  }
}
