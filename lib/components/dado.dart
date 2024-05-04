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
    //verCombinaciones(numerosDados);
  }

  Widget verCombinaciones(List<int> numerosDados){
    var conteo = Map<int,int>();
    String resultado = '';

    // Conteo de los dados
    for(var numDado in numerosDados){
      conteo[numDado] = (conteo[numDado] ?? 0) + 1;
    }
    // Verificar si hay generala
    if(conteo.containsValue(5)){
      resultado = '¡Generala!';
    }
    // Verificar si hay póker
    else if(conteo.containsValue(4)){
      int numeroPoker = conteo.entries.firstWhere((entry) => entry.value == 4).key;
      resultado = 'Póker de $numeroPoker';
    }
    // Verificar si hay full
    else if(conteo.containsValue(3) && conteo.containsValue(2)){
      resultado = 'Full';
    }
    // Verificar si hay escalera
    else if(conteo.keys.toSet().containsAll({1, 2, 3, 4, 5}) || conteo.keys.toSet().containsAll({2, 3, 4, 5, 6}) || conteo.keys.toSet().containsAll({3, 4, 5, 6, 1}) || conteo.keys.toSet().containsAll({2, 4, 5, 6, 1})){
      resultado = 'Escalera';
    }
    // Verificar si hay trío
    else if(conteo.containsValue(3)){
      int numeroTrio = conteo.entries.firstWhere((entry) => entry.value == 3).key;
      resultado = '3 al $numeroTrio';
    }
    // Verificar si hay doble par
    else if(conteo.values.where((cantidad) => cantidad == 2).length == 2){
      resultado = 'Doble par';
    }
    // Verificar si hay par
    else if(conteo.containsValue(2)){
      int numeroPar = conteo.entries.firstWhere((entry) => entry.value == 2).key;
      resultado = 'Dos al $numeroPar';
    }

    // Si no hay ninguna combinación especial, mostrar la cantidad de cada dado
    if(resultado.isEmpty){
      conteo.forEach((numero, cantidad) {
        resultado += 'Número $numero: $cantidad veces\n';
      });
    }
    return Text(resultado, style: TextStyle(fontSize: 24));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verCombinaciones(numerosDados),
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
