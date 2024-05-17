import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_event.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';
import '../screens/product_list_screen.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            final carniceriaBloc = context.read<CarniceriaBloc>();
            final state = carniceriaBloc.state;

            // Verificar que todos los elementos necesarios estén seleccionados
            final bool isCategorySelected = state.selectedProductType != null;
            final bool isScaleSelected = state.selectedScale != null;
            final bool isPrinterSelected = state.selectedPrinter != null;
            final bool isSummarySelected = state.summaries.isNotEmpty;

            if (isCategorySelected && isScaleSelected && isPrinterSelected && isSummarySelected) {
              // Agrega el evento para obtener la lista de productos
              carniceriaBloc.add(FetchProductList(
                state.selectedProductType!,
                state.isButchery,
                state.summaries,
              ));

              // Escucha el cambio de estado para navegar cuando los productos se carguen
              carniceriaBloc.stream.firstWhere((state) => state.products.isNotEmpty).then((_) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              });
            } else {
              // Mostrar mensaje de error si algún elemento no está seleccionado
              String errorMessage = 'Seleccione:';
              if (!isCategorySelected) errorMessage += '\n- una categoría';
              if (!isScaleSelected) errorMessage += '\n- una báscula';
              if (!isPrinterSelected) errorMessage += '\n- una impresora';
              if (!isSummarySelected) errorMessage += '\n- al menos un resumen';

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
