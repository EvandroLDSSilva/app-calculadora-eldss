import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else if (valor == 'dolar 💵') {
        _expressao += '5.84';
      } else if (valor == 'euro 💶') {
        _expressao += '6.39';
      } else if (valor == 'libra 💷') {
        _expressao += '7.23';
      } else if (valor == 'yene 💴') {
        _expressao += '0.04';
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      //_resultado = _resultado = _expressao.split('=').last;
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro: não é possivel calcular';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');

    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Text(_expressao, style: const TextStyle(fontSize: 24))),
        Expanded(child: Text(_resultado, style: const TextStyle(fontSize: 24))),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: [
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('÷'),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('x'),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('-'),
              _botao('0'),
              _botao('.'),
              _botao('='),
              _botao('+'),
              //botaos de cotaçoes de moedas no dia 01/02/24, 10:12:25.
              //o botao deve ajudar automatizando e nao necessitando pesquisar a cotaçao das moedas desse dia
              _botao('dolar 💵'),
              _botao('euro 💶'),
              _botao('libra 💷'),
              _botao('yene 💴'),
            ],
          ),
        ),
        Expanded(child: _botao('Limpar')),
      ],
    );
  }
}
