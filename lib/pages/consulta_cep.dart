import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trilhaapp/model/viacep_model.dart';
import 'package:trilhaapp/repositories/via_cep_repository.dart';
import 'package:easy_localization/easy_localization.dart';

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({super.key});

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viaCEPModel = ViaCEPModel();
  var viaCepRepository = ViaCepRepository();

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
              "CONSULTA_CEP".tr(),
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.purple,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.purple[50],
                contentPadding: EdgeInsets.only(top: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                hintText: "CEP",
                hintStyle: TextStyle(
                  color: Colors.purple,
                ),
                prefixIcon: Icon(Icons.place, color: Colors.purple,),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
            ),
            SizedBox(
              height: 10,
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
                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                if (cep.length == 8) {
                  setState(() {
                    loading = true;
                  });
                  viaCEPModel = await viaCepRepository.consultarCEP(cep);
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
                  if (loading) CircularProgressIndicator(),
                  Text(
                    viaCEPModel.logradouro ?? "",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    "${viaCEPModel.localidade ?? ""} - ${viaCEPModel.uf ?? ""}",
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
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () async {}),
    ));
  }
}
