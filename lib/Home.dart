import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  void _recuperarPreco() async {

    String url = "https://blockchain.info/ticker";
    htpp.Response response = await htpp.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _preco = "" + retorno["BRL"]["buy"].toString();
    });

    print("Resultado :" + retorno["BRL"]["buy"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/bitcoin.png"),
            const Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            ),
            Text(
                "R\$ " + _preco,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
             ElevatedButton(
              onPressed: _recuperarPreco,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
              ),
              child: const Text(
                  "Atualizar",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
            ),
          ],
        ),
      ),
    )
      );
  }
}
