import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/products/products_bloc.dart';
import '../../structure/bloc/products/products_event.dart';
import '../../structure/bloc/products/products_state.dart';

class LotNumberModal extends StatefulWidget {
  const LotNumberModal({super.key});

  @override
  _LotNumberModalState createState() => _LotNumberModalState();
}

class _LotNumberModalState extends State<LotNumberModal> {
  String input = "";

  void _handleNumberInput(String number) {
    setState(() {
      input += number;
    });
  }

  void _handleBackspace() {
    setState(() {
      input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
    });
  }

  void _handleAccept(BuildContext context) {
    if (input.isNotEmpty) {
      final lotNumber = int.parse(input);
      BlocProvider.of<ProductBloc>(context).add(UpdateLotNumber(lotNumber));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('NÚMERO DE LOT'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(input, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          _buildNumberPad(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => _handleAccept(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        _buildNumberRow(['7', '8', '9']),
        _buildNumberRow(['4', '5', '6']),
        _buildNumberRow(['1', '2', '3']),
        _buildNumberRow(['C', '0', '<']),
      ],
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        return ElevatedButton(
          onPressed: () {
            if (number == 'C') {
              setState(() {
                input = "";
              });
            } else if (number == '<') {
              _handleBackspace();
            } else {
              _handleNumberInput(number);
            }
          },
          child: Text(number, style: const TextStyle(fontSize: 24)),
        );
      }).toList(),
    );
  }
}