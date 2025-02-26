import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/viacep_model.dart';

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController(text: "");
  String endereco = "";
  String cidade = "";
  String estado = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Consulta de CEP",
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              style: TextStyle(
                color: Colors.purple,
              ),
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.purple[50],
                  contentPadding: EdgeInsets.only(top: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "00000000",
                  hintStyle: TextStyle(
                    color: Colors.purple,
                  ),
                  prefixIcon: Icon(
                    Icons.place,
                    color: Colors.purple,
                  )),
              onChanged: (String value) async {
                setState(() {
                  loading = true;
                });
                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                debugPrint(cep);
                if (cep.length == 8) {
                  var response = await http
                      .get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
                  debugPrint(response.statusCode.toString());
                  var json = jsonDecode(response.body);
                  var viaCEPModel = ViaCEPModel.fromJson(json);
                  //print(viaCEPModel);
                  cidade = viaCEPModel.localidade ?? "";
                  estado = viaCEPModel.uf ?? "";
                  endereco = viaCEPModel.logradouro ?? "";
                } else {
                  cidade = "";
                  estado = "";
                  endereco = "";
                }
                setState(() {
                  loading = false;
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 120,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    if(loading) CircularProgressIndicator(),
                  Text(
                    endereco,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    "$cidade - $estado",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            var response = await http.get(Uri.parse("https://www.google.com"));
            debugPrint(response.statusCode.toString());
            debugPrint(response.body);
          }),
    ));
  }
}
