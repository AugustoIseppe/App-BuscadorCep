import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*  AQUI FOI INCLUIDO UMA ALTERAÇÃO NO CÓDIGO  */

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = 'Resultado';

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    var url = Uri.parse("https://viacep.com.br/ws/${cepDigitado}/json/");
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String localidade = retorno['localidade'];
    String logradouro = retorno['logradouro'];
    String bairro = retorno['bairro'];
    String cep = retorno['cep'];
    String ddd = retorno['ddd'];
    String uf = retorno['uf'];

    setState(() {
      _resultado = "${logradouro}, ${bairro}. Localidade: ${localidade}, UF: ${uf} - CEP: ${cep} - DDD: ${ddd}";
    });

    // print('Logradouro = ${logradouro}'
    //     'complemento = ${localidade}'
    //     'bairro = ${bairro}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Requisições'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Digite o CEP (apenas números)'),
              style: TextStyle(fontSize: 15),
              controller: _controllerCep,
            ),
            ElevatedButton(
              onPressed: _recuperarCep,
              child: Text('Buscar CEP'),
            ),
            Text(_resultado, 
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}
