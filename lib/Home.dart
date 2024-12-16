import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _precoUSD = "0";
  String _precoBRL = "0";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _precoUSD = retorno["USD"]["buy"].toString();
      _precoBRL = retorno["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Image.asset("images/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 0),
                child: Text(
                  "R\$ " + _precoBRL,
                  style: TextStyle(
                    fontSize: 35
                  ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                  "\$ " + _precoUSD,
                  style: TextStyle(
                      fontSize: 35
                  ),
                ),
              ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                        ),
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                        ),
                    ),
                    onPressed: _recuperarPreco
                    ),
            ],
          ),
        ),
      ),
    );
  }
}