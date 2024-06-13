import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../../structure/bloc/carniceria/carniceria_event.dart';
import '../../../structure/bloc/carniceria/carniceria_state.dart';

class CategoryColumn extends StatefulWidget {
  const CategoryColumn({super.key});

  @override
  _CategoryColumnState createState() => _CategoryColumnState();
}

class _CategoryColumnState extends State<CategoryColumn> {
  List<dynamic> buttons = [];
  bool isSwitchEnabled = false;
  bool isSwitchActive = false;
  String? selectedProductType;

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
          bool shouldScroll = buttons.length > 6;

          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  physics: shouldScroll ? null : const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.only(top: 60, left: 30, right: 10),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    var button = buttons[index];
                    return _buildButton(context, button['text'], button['productType'], button['isButchery'], state.selectedProductType);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: _buildSwitch(context, AppLocalizations.of(context)!.butchershop, state.isButchery),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String productType, bool isButchery, String? selectedProductType) {
    bool isSelected = selectedProductType == productType || this.selectedProductType == productType;
    Color color = isSelected ? Colors.green : Colors.grey.shade300;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: const Size(100, 80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          context.read<CarniceriaBloc>().add(FetchSummaries(productType));
          setState(() {
            isSwitchEnabled = isButchery;
            if (!isButchery) {
              isSwitchActive = false;
              context.read<CarniceriaBloc>().add(ToggleButchery(false));
            }
            this.selectedProductType = productType;
          });
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
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
          style: const TextStyle(fontSize: 30),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Transform.scale(
            scale: 1.4,
            child: Switch(
              value: isSwitchActive && isButchery,
              onChanged: isSwitchEnabled ? (value) {
                setState(() {
                  isSwitchActive = value;
                });
                context.read<CarniceriaBloc>().add(ToggleButchery(value));
              } : null,
            ),
          ),
        ),
      ],
    );
  }
}
