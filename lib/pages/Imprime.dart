import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:ordemservico/pages/Pedido.dart';

import '../model/pedido.dart';

// ignore: must_be_immutable, camel_case_types
class imprime extends StatefulWidget {
  imprime({Key? key, required this.pedido}) : super(key: key);
  Pedido pedido;

  @override
  State<imprime> createState() => _imprimeState();
}

// ignore: camel_case_types
class _imprimeState extends State<imprime> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  List<BluetoothDevice> _devices = [];
  String _deviceMsg = '';

  @override
  void initState() {
    super.initState();
    busca();
  }

  void busca() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bluetoothPrint.startScan(timeout: const Duration(seconds: 6));
      if (!mounted) return;
      bluetoothPrint.scanResults.listen((val) {
        if (!mounted) return;
        setState(() {
          _devices = val;
          _deviceMsg = '';
        });
        if (_devices.isEmpty) {
          setState(() {
            _deviceMsg = 'Nenhum dispositivo encontrado';
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexão/Impressão',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xff790B00),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              busca();
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xff252525),
      body: _devices.isEmpty
          ? Center(
              child:
                  Text(_deviceMsg, style: const TextStyle(color: Colors.white)),
            )
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (c, i) {
                return ListTile(
                  leading: const Icon(Icons.print),
                  title: Text(_devices[i].name ?? ''),
                  subtitle: Text(_devices[i].address!),
                  onTap: () async {
                    _startPrint(_devices[i]);
                    Navigator.push(context, const dados() as Route<Object?>);
                  },
                );
              },
            ),
    );
  }

  Future<void> _startPrint(BluetoothDevice device) async {
    if (device != null && device.address != null) {
      Map<String, dynamic> config = {};
      List<LineText> list = [];
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Cliente: ${widget.pedido.nome}',
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "-------------------------------",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Lanches:',
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      for (int i = 0; i < widget.pedido.lanches.length; i++) {
        list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: widget.pedido.lanches[i],
          width: 2,
          height: 2,
          weight: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ));
      }
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "-------------------------------",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "Observação:",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: widget.pedido.observacao,
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "-------------------------------",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "Bebidas:",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      for (int i = 0; i < widget.pedido.bebidas.length; i++) {
        list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: widget.pedido.bebidas[i],
          width: 2,
          height: 2,
          weight: 2,
          align: LineText.ALIGN_CENTER,
          linefeed: 1,
        ));
      }
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "-------------------------------",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "Para entregar : ${widget.pedido.viagem ? 'Sim' : 'Não'}",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "-------------------------------",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "Valor: R\$ ${widget.pedido.valor}",
        width: 2,
        height: 2,
        weight: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ));
      await bluetoothPrint.printReceipt(config, list);
    }
  }
}
