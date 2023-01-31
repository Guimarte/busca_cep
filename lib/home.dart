import 'package:buscar_cep/models/cep_models.dart';
import 'package:buscar_cep/repository/cep_repository.dart';
import 'package:buscar_cep/utils/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share_plus/share_plus.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final formkey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Busca CEP"),centerTitle: true, ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(8),
                                top: Radius.circular(18))),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(8),
                            top: Radius.circular(18)))),
                    maxLength: 8,
                    showCursor: true,
                    controller: controller,
                    validator: (String? value ) {
                      if (value == null || value.isEmpty) {
                        return "Insira seu cep";
                      }
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState?.validate() == true) {
                      CepReposiroty cepReposiroty = CepReposiroty();
                      var cidade =
                          await cepReposiroty.buscaCep(controller.value.text);
                      if (cidade != null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok")),

                                  TextButton(
                                      onPressed: () {
                                        Share.share(
                                            "Sua busca resultou em \n Cep: ${cidade.cep} \n Logradouro: ${cidade.logradouro} \n Cidade: ${cidade.localidade} \n Estado: ${cidade.uf}. ");
                                      },
                                      child: Text("Compartilhar")),
                                ],
                                elevation: 8,
                                title: Text("Lista CEP"),
                                content: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    child: ListView(
                                      children: [
                                        Text("Cep: ${cidade.cep}"),
                                        Text(
                                            "Logradouro: ${cidade.logradouro}"),
                                        Text("Cidade: ${cidade.localidade}"),
                                        Text("Estado: ${cidade.uf}")
                                      ],
                                    )),
                              );
                            });
                      }
                      print(cidade);
                    }
                  },
                  child: Text("Buscar"))
            ]),
      ),
    );
  }
}
