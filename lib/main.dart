import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home:dados()),);
}
// ignore: camel_case_types
class dados extends StatefulWidget {
  const dados({super.key});

  @override
  State<dados> createState() => _dadosState();
}

// ignore: camel_case_types
class _dadosState extends State<dados> {
  // ignore: non_constant_identifier_names
  List<String> Selected=['Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar'];
  // ignore: non_constant_identifier_names
  List<String> Selectedvalue=['Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar','Selecionar'];
  bool viagem =false;
  int numero = 1;
  int numero2 = 1;
  TextEditingController nome = TextEditingController();
  TextEditingController OBS = TextEditingController();
  TextEditingController valorp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fazer pedido"),
        centerTitle: true,
        backgroundColor:  Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed:Enviar,
          ),
        ],
      ),
      backgroundColor: const Color(0xff252525),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [Column(
              children: [
                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  controller: nome,
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Numero de lanches",style: TextStyle(color: Colors.white),),
                    const SizedBox(width: 10,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.cyan,
                      ),

                      child: DropdownButton<int>(
                        value: numero,
                        onChanged: (int? newValue) {
                          setState(() {
                            numero = newValue!;
                          });
                        },
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        items: <int>[1,2,3,4,5,6,7,8,9,10]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.toString()),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],),
                for (int i=0;i<numero;i++)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.cyan,

                    ),
                    margin: const EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      value: Selected[i],
                      onChanged: (String? newValue) {
                        setState(() {
                          Selected[i] = newValue!;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),

                      items: <String>['Cachorro quente','Cachorro quente duplo', 'Misto', 'Hamburguer ', 'Hamburguer duplo', 'Selecionar']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value,
                               style: const TextStyle(color: Colors.white),),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                const SizedBox(height: 10,),
                TextField(
                  decoration: const  InputDecoration(
                    labelText: "OBS",
                    labelStyle: TextStyle(color: Colors.white),
                    border:  OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  controller: OBS,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Numero de bebidas",style: TextStyle(color: Colors.white),),
                    const SizedBox(width: 10,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.cyan,
                      ),
                      child: DropdownButton<int>(
                        value: numero2,
                        onChanged: (int? newValue) {
                          setState(() {
                            numero2 = newValue!;
                          });
                        },
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        dropdownColor: Colors.cyan,
                        items: <int>[1,2,3,4,5,6,7,8,9,10]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value.toString()),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],),
                const SizedBox(height: 10,),
                for(int i=0;i<numero2;i++)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.cyan,
                    ),
                    margin: const EdgeInsets.all(10),
                    child: DropdownButton<String>(
                      value: Selectedvalue[i],
                      onChanged: (String? newValue) {
                        setState(() {
                          Selectedvalue[i] = newValue!;
                        });
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      dropdownColor: Colors.cyan,
                      items: <String>['Suco Uva', 'Suco Morango','Coca Cola lata','Coca Cola 2L', 'Fanta lata','Fanta 2L', 'Sprite lata','Sprite 2L', 'Selecionar']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text("P/Viagem:",style: TextStyle(color: Colors.white),),
                  Checkbox(value: viagem, onChanged: (value) {
                    setState(() {
                      viagem = value!;
                    });
                  }),
                ],),
                const SizedBox(height: 10,),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "valor",
                    suffix: Text("R\$"),
                    suffixStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  controller: valorp,
                ),
              ],
            ),
          ]),
        ),
      ),);
  }
  // ignore: non_constant_identifier_names
  void Enviar(){
    int total = numero;
    int total2 = numero2;
    String nomecliente= nome.text;
    String obs = OBS.text;
    String valor = valorp.text;
    List<String> lanches = [];
    List<String> bebidas = [];
    for(int i=0;i<total;i++){
      lanches.add(Selected[i]);
    }
    for(int i=0;i<total2;i++){
      bebidas.add(Selectedvalue[i]);
    }
    print("Nome do cliente: $nomecliente");
    print("Lanches: $lanches");
    print("OBS: $obs");
    print("Bebidas: $bebidas");
    print("Viagem: ${viagem ? "Sim" : "Não"}");
    print("Valor:R\$ $valor");
  }
}
