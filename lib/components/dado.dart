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
  List<bool> dadosBloq = [false,false,false,false,false];

  void lanzarDados() {
    setState(() {
      for (int i = 0; i < numerosDados.length; i++) {
        if (!dadosBloq[i]){
          numerosDados[i] = rng.nextInt(6) + 1;
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: numerosDados.asMap().entries.map((entry) {
            int idx = entry.key;
            int numero = entry.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  // Aquí inviertes el estado de bloqueo del dado correspondiente
                  dadosBloq[idx] = !dadosBloq[idx];
                });
              },
              child: Opacity(
                opacity: dadosBloq[idx] ? 0.5 : 1, // Los dados bloqueados se muestran con menos opacidad
                child: Dado(numDado: numero),
              ),
            );
          }).toList(),
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
