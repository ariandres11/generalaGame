import 'dart:math';
import 'package:flutter/material.dart';

class Dado extends StatefulWidget {
  final int numDado;

  Dado({Key? key, this.numDado = 1}) : super(key: key);

  @override
  _DadoState createState() => _DadoState();
}

class _DadoState extends State<Dado> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: Image.asset('assets/images/d${widget.numDado}.png'),
    );
  }
}

class Juego extends StatefulWidget {
  @override
  _JuegoState createState() => _JuegoState();
}

class _JuegoState extends State<Juego> {
  var rng = new Random();
  List<int> numerosDados = [1, 1, 1, 1, 1];

  void lanzarDados() {
    setState(() {
      for (int i = 0; i < numerosDados.length; i++) {
        numerosDados[i] = rng.nextInt(6) + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children:
              numerosDados.map((numero) => Dado(numDado: numero)).toList(),
        ),
        ElevatedButton(
          onPressed: lanzarDados,
          child: Text(
              'Lanzar dados',
              style: TextStyle(
                fontFamily: 'FreemanReg',
                fontSize: 40,
              ),
          ),
        ),
      ],
    );
  }
}
