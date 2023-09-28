import 'package:flutter/material.dart';
import 'package:selinap/const.dart';

class PiketDialog extends StatefulWidget {
  const PiketDialog({super.key});

  @override
  State<PiketDialog> createState() => _PiketDialogState();
}

class _PiketDialogState extends State<PiketDialog> {
  TextEditingController ctrlKeterangan = TextEditingController();
  TextEditingController ctrlJenisPel = TextEditingController();

  // Initial Selected Value
  String dropdownvalue = 'Pilih Pelanggaran';

  // List of items in our dropdown menu
  var uri = Uri.parse('$BaseURL/pelanggaran/search.php');

  get items => null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Data'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              // Initial Value
              value: dropdownvalue,
              hint: Text("Pilih Jenis Pelanggaran"),

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
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
            SizedBox(
              height: 10,
            ),

            // Text("Point"), Text("18"),
            //   TextField(
            //      controller: ctrlPoint,
            // // keyboardType: TextInputType.number,
            // decoration: const InputDecoration(
            //   label: Text('Point Pelanggaran'),
            // ),
            // ),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // addData();
            // getData('');
            Navigator.of(context).pop();
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
