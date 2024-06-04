import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_event.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';

class CategoryColumn extends StatefulWidget {
  @override
  _CategoryColumnState createState() => _CategoryColumnState();
}

class _CategoryColumnState extends State<CategoryColumn> {
  List<dynamic> buttons = [];

  @override
  void initState() {
    super.initState();
    _loadButtons();
  }

  Future<void> _loadButtons() async {
    final String response = await rootBundle.loadString('assets/data/botones_categorias.json');
    final data = await json.decode(response);
    setState(() {
      buttons = data['buttons'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CarniceriaBloc, CarniceriaState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 60), // Margen superior para el botón de carnicería
                child: _buildSwitch(context, 'CARNICERIA    ', state.isButchery),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 10,
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  crossAxisSpacing: 10,
                  children: buttons.map<Widget>((button) {
                    return _buildButton(context, button['text'], button['productType'], state.selectedProductType);
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String productType, String? selectedProductType) {
    bool isSelected = selectedProductType == productType;
    Color color = isSelected ? Colors.green : Colors.grey.shade300;

    return Container(
      margin: EdgeInsets.only(top: 10), // Margen superior
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(100, 50), // Ajustar el tamaño mínimo del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Bordes redondeados
          ),
        ),
        onPressed: () {
          context.read<CarniceriaBloc>().add(FetchSummaries(productType));
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20), // Ajustar el tamaño del texto
        ),
      ),
    );
  }

  Widget _buildSwitch(BuildContext context, String text, bool isButchery) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 26),
        ),
        Transform.scale(
          scale: 1.4,
          child: Switch(
            value: isButchery,
            onChanged: (value) {
              context.read<CarniceriaBloc>().add(ToggleButchery(value));
            },
          ),
        ),
      ],
    );
  }
}
