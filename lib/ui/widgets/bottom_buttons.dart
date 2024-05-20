import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_event.dart';
import '../screens/product_list_screen.dart';
import '../../structure/bloc/configuration/configuration_bloc.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final carniceriaBloc = context.read<CarniceriaBloc>();
            final carniceriaState = carniceriaBloc.state;

            final configurationBloc = context.read<ConfigurationBloc>();
            final configurationState = configurationBloc.state;

            final bool isCategorySelected = carniceriaState.selectedProductType != null;
            final bool isScaleSelected = configurationState.selectedScale != null;
            final bool isPrinterSelected = configurationState.selectedPrinter != null;
            final bool isSummarySelected = carniceriaState.summaries.isNotEmpty;

            if (isCategorySelected && isScaleSelected && isPrinterSelected && isSummarySelected) {
              carniceriaBloc.add(FetchProductList(
                carniceriaState.selectedProductType!,
                carniceriaState.isButchery,
                carniceriaState.summaries,
              ));

              carniceriaBloc.stream.firstWhere((state) => state.products.isNotEmpty).then((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              });
            } else {
              String errorMessage = 'Selecciona:';
              if (!isCategorySelected) errorMessage += '\n- una categoría';
              if (!isScaleSelected) errorMessage += '\n- una báscula';
              if (!isPrinterSelected) errorMessage += '\n- una impresora';
              if (!isSummarySelected) errorMessage += '\n- al menys un resum';

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMessage)),
              );
            }
          },
          icon: Icon(Icons.check, color: Colors.black),
          label: Text('Aceptar', style: TextStyle(color: Colors.black, fontSize: 27)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 10, horizontal: 20)), // Relleno del botón
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
