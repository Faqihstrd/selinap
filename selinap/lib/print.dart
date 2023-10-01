import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_bluetooth_pos_printer/smart_bluetooth_pos_printer.dart';

import 'model/laporan_model.dart';

class PrintBt extends StatefulWidget {
  //final List<Map<String, dynamic>> data;
  final LaporanModel item;
  const PrintBt(this.item, {super.key});

  @override
  State<PrintBt> createState() => _PrintBtState();
}

class _PrintBtState extends State<PrintBt> {
//   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
//   var now = DateTime.now();
//   var formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss');

//   bool _connected = false;
//   BluetoothDevice? _device;
//   String tips = 'no device connect';

//   // final f = NumberFormat("\$###,###.00", "en_US");

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
//   }

//   Future<void> initBluetooth() async {
//     bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

//     bool isConnected = await bluetoothPrint.isConnected ?? false;

//     bluetoothPrint.state.listen((state) {
//       print('******************* cur device status: $state');

//       switch (state) {
//         case BluetoothPrint.CONNECTED:
//           setState(() {
//             _connected = true;
//             tips = 'connect success';
//           });
//           break;
//         case BluetoothPrint.DISCONNECTED:
//           setState(() {
//             _connected = false;
//             tips = 'disconnect success';
//           });
//           break;
//         default:
//           break;
//       }
//     });

//     if (!mounted) return;

//     if (isConnected) {
//       setState(() {
//         _connected = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Print Laporan Pelanggaran'),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () =>
//               bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 10),
//                       child: Text(tips),
//                     ),
//                   ],
//                 ),
//                 const Divider(),
//                 StreamBuilder<List<BluetoothDevice>>(
//                   stream: bluetoothPrint.scanResults,
//                   initialData: const [],
//                   builder: (c, snapshot) => Column(
//                     children: snapshot.data!
//                         .map((d) => ListTile(
//                               title: Text(d.name ?? ''),
//                               subtitle: Text(d.address ?? ''),
//                               onTap: () async {
//                                 setState(() {
//                                   _device = d;
//                                 });
//                               },
//                               trailing: _device != null &&
//                                       _device!.address == d.address
//                                   ? const Icon(
//                                       Icons.check,
//                                       color: Colors.green,
//                                     )
//                                   : null,
//                             ))
//                         .toList(),
//                   ),
//                 ),
//                 const Divider(),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
//                   child: Column(
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           OutlinedButton(
//                             onPressed: _connected
//                                 ? null
//                                 : () async {
//                                     if (_device != null &&
//                                         _device!.address != null) {
//                                       setState(() {
//                                         tips = 'connecting...';
//                                       });
//                                       await bluetoothPrint.connect(_device!);
//                                     } else {
//                                       setState(() {
//                                         tips = 'please select device';
//                                       });
//                                       print('please select device');
//                                     }
//                                   },
//                             child: const Text('connect'),
//                           ),
//                           const SizedBox(width: 10.0),
//                           OutlinedButton(
//                             onPressed: _connected
//                                 ? () async {
//                                     setState(() {
//                                       tips = 'disconnecting...';
//                                     });
//                                     await bluetoothPrint.disconnect();
//                                   }
//                                 : null,
//                             child: const Text('disconnect'),
//                           ),
//                         ],
//                       ),
//                       const Divider(),
//                       OutlinedButton(
//                         onPressed: _connected
//                             ? () async {
//                                 Map<String, dynamic> config = {};

//                                 List<LineText> list = [];

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content:
//                                         '************************************',
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1));
//                                 list.add(
//                                   LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: "Grocery App",
//                                     weight: 2,
//                                     width: 2,
//                                     height: 2,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1,
//                                   ),
//                                 );
//                                 list.add(LineText(linefeed: 1));

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '-------Laporan Pelanggaran------',
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1));

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: formattedDate.format(now),
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1));

//                                 for (var i = 0; i < widget.item.hashCode; i++) {
//                                   list.add(
//                                     LineText(
//                                       type: LineText.TYPE_TEXT,
//                                       content: widget.item.nisPelajar,
//                                       weight: 0,
//                                       align: LineText.ALIGN_LEFT,
//                                       linefeed: 1,
//                                     ),
//                                   );
//                                   list.add(
//                                     LineText(
//                                       type: LineText.TYPE_TEXT,
//                                       content: widget.item.namaPelajar,
//                                       weight: 0,
//                                       align: LineText.ALIGN_LEFT,
//                                       linefeed: 1,
//                                     ),
//                                   );
//                                   list.add(
//                                     LineText(
//                                       type: LineText.TYPE_TEXT,
//                                       content: widget.item.namaPelanggaran,
//                                       weight: 0,
//                                       align: LineText.ALIGN_LEFT,
//                                       linefeed: 1,
//                                     ),
//                                   );
//                                   list.add(
//                                     LineText(
//                                       type: LineText.TYPE_TEXT,
//                                       content:
//                                           "${formattedDate.format(DateTime.parse(widget.item.tanggalPelanggaran ?? ""))} x ${widget.item}",
//                                       align: LineText.ALIGN_LEFT,
//                                       linefeed: 1,
//                                     ),
//                                   );
//                                 }

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content:
//                                         '*****************************************',
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1));
//                                 list.add(LineText(linefeed: 1));

//                                 // ByteData data =
//                                 //     await rootBundle.load("assets/logo.png");
//                                 // List<int> imageBytes = data.buffer.asUint8List(
//                                 //     data.offsetInBytes, data.lengthInBytes);
//                                 // String base64Image = base64Encode(imageBytes);
//                                 // list.add(
//                                 //   LineText(
//                                 //       type: LineText.TYPE_IMAGE,
//                                 //       content: base64Image,
//                                 //       align: LineText.ALIGN_CENTER,
//                                 //       width: 200,
//                                 //       linefeed: 1),
//                                 // );

//                                 await bluetoothPrint.printReceipt(config, list);
//                                 print('Image printed successfully');
//                               }
//                             : null,
//                         child: const Text('print receipt(esc)'),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: StreamBuilder<bool>(
//           stream: bluetoothPrint.isScanning,
//           initialData: false,
//           builder: (c, snapshot) {
//             if (snapshot.data == true) {
//               return FloatingActionButton(
//                 onPressed: () => bluetoothPrint.stopScan(),
//                 backgroundColor: Colors.red,
//                 child: const Icon(Icons.stop),
//               );
//             } else {
//               return FloatingActionButton(
//                   child: const Icon(Icons.search),
//                   onPressed: () => bluetoothPrint.startScan(
//                       timeout: const Duration(seconds: 4)));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

  var _isBle = false;
  var _reconnect = false;
  var _isConnected = false;
  var printerManager = PrinterManager.instance;
  var devices = <BluetoothPrinter>[];
  StreamSubscription<List<PrinterDevice>>? _subscription;
  StreamSubscription<BTStatus>? _subscriptionBtStatus;
  BTStatus _currentStatus = BTStatus.none;
  // _currentUsbStatus is only supports on Android
  // ignore: unused_field
  List<int>? pendingTask;
  BluetoothPrinter? selectedPrinter;
  var formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss');

  @override
  void initState() {
    super.initState();

    _scan();

    // subscription to listen change status of bluetooth connection
    _subscriptionBtStatus =
        PrinterManager.instance.stateBluetooth.listen((status) {
      log(' ----------------- status bt $status ------------------ ');
      _currentStatus = status;
      if (status == BTStatus.connected) {
        setState(() {
          _isConnected = true;
        });
      }
      if (status == BTStatus.none) {
        setState(() {
          _isConnected = false;
        });
      }
      if (status == BTStatus.connected && pendingTask != null) {
        if (Platform.isAndroid) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            PrinterManager.instance.send(bytes: pendingTask!);
            pendingTask = null;
          });
        } else if (Platform.isIOS) {
          PrinterManager.instance.send(bytes: pendingTask!);
          pendingTask = null;
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscriptionBtStatus?.cancel();

    super.dispose();
  }

  // method to scan devices according PrinterType
  void _scan() {
    printerManager.startScan(timeout: const Duration(seconds: 4), isBle: true);
    _subscription = printerManager.scanResults().listen((results) {
      devices.clear();
      for (PrinterDevice r in results) {
        devices.add(BluetoothPrinter(
          deviceName: r.name,
          address: r.address,
          isBle: _isBle,
        ));
      }
      print(devices.length);
      setState(() {});
    });
  }

  void selectDevice(BluetoothPrinter device) async {
    if (selectedPrinter != null) {
      if (device.address != selectedPrinter!.address) {
        await PrinterManager.instance.disconnect();
      }
    }

    selectedPrinter = device;
    setState(() {});
  }

  Future _printLaporan() async {
    List<int> bytes = [];

    // Xprinter XP-N160I
    final profile = await CapabilityProfile.load();
    // PaperSize.mm80 or PaperSize.mm58
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.setGlobalCodeTable('CP1252');
    bytes += generator.text('********************************');
    bytes += generator.text('Selinap',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('********************************');
    bytes += generator.text(
        formattedDate
            .format(DateTime.parse(widget.item.tanggalPelanggaran ?? '')),
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('********************************');
    bytes += generator.text('Nis\t    : ${widget.item.nisPelajar}');
    bytes += generator.text('Nama\t    : ${widget.item.namaPelajar}');
    bytes += generator.text('Kelas\t    : ${widget.item.namaPelajar}');
    bytes += generator.text('Pelanggaran : ${widget.item.namaPelanggaran}');
    bytes += generator.text('Point\t    : ${widget.item.poinPelanggaran}');
    bytes += generator.text('********************************');
    bytes += generator.text('Total Point : ${widget.item.poinPelajar}');
    bytes += generator.text('********************************');

    _printEscPos(bytes, generator);
  }

  /// print ticket
  void _printEscPos(List<int> bytes, Generator generator) async {
    if (selectedPrinter == null) return;
    var bluetoothPrinter = selectedPrinter!;

    bytes += generator.cut();
    await printerManager.connect(
        model: BluetoothPrinterInput(
            name: bluetoothPrinter.deviceName,
            address: bluetoothPrinter.address!,
            isBle: bluetoothPrinter.isBle ?? false,
            autoConnect: _reconnect));
    pendingTask = null;
    if (Platform.isAndroid) pendingTask = bytes;

    if (Platform.isAndroid) {
      if (_currentStatus == BTStatus.connected) {
        printerManager.send(bytes: bytes);
        pendingTask = null;
      }
    } else {
      printerManager.send(bytes: bytes);
    }
  }

  // conectar dispositivo
  _connectDevice() async {
    _isConnected = false;
    if (selectedPrinter == null) return;
    await printerManager.connect(
        model: BluetoothPrinterInput(
            name: selectedPrinter!.deviceName,
            address: selectedPrinter!.address!,
            isBle: selectedPrinter!.isBle ?? false,
            autoConnect: _reconnect));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Pos Plugin Platform example app'),
        ),
        body: Center(
          child: Container(
            height: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedPrinter == null || _isConnected
                                ? null
                                : () {
                                    _connectDevice();
                                  },
                            child: const Text("Connect",
                                textAlign: TextAlign.center),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedPrinter == null || !_isConnected
                                ? null
                                : () {
                                    if (selectedPrinter != null) {
                                      printerManager.disconnect();
                                      setState(() {
                                        _isConnected = false;
                                      });
                                    }
                                  },
                            child: const Text("Disconnect",
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: Platform.isAndroid,
                    child: SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets.only(bottom: 20.0, left: 20),
                      title: const Text(
                        "This device supports ble (low energy)",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 19.0),
                      ),
                      value: _isBle,
                      onChanged: (bool? value) {
                        setState(() {
                          _isBle = value ?? false;
                          _isConnected = false;
                          selectedPrinter = null;
                          _scan();
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: Platform.isAndroid,
                    child: SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets.only(bottom: 20.0, left: 20),
                      title: const Text(
                        "reconnect",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 19.0),
                      ),
                      value: _reconnect,
                      onChanged: (bool? value) {
                        setState(() {
                          _reconnect = value ?? false;
                        });
                      },
                    ),
                  ),
                  Column(
                      children: devices
                          .map(
                            (device) => ListTile(
                              title: Text('${device.deviceName}'),
                              onTap: () {
                                // do something
                                selectDevice(device);
                              },
                              leading: selectedPrinter != null &&
                                      ((device.address != null &&
                                          selectedPrinter!.address ==
                                              device.address))
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                              trailing: OutlinedButton(
                                onPressed: selectedPrinter == null ||
                                        device.deviceName !=
                                            selectedPrinter?.deviceName
                                    ? null
                                    : () async {
                                        _printLaporan();
                                      },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 20),
                                  child: Text("Print Laporan",
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          )
                          .toList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  bool? isBle;

  bool? state;

  BluetoothPrinter(
      {this.deviceName, this.address, this.state, this.isBle = false});
}
