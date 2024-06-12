import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data/repositories/pesaje_repository.dart';
import '../../../data/services/api_service.dart';
import '../../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../../structure/bloc/carniceria/carniceria_event.dart';
import '../../../structure/bloc/carniceria/carniceria_state.dart';
import '../../screens/product_list_screen.dart';
import '../../../structure/bloc/configuration/configuration_bloc.dart';
import '../../../structure/bloc/configuration/configuration_state.dart';

class BottomButtons extends StatelessWidget {
  final ApiService apiService;

  const BottomButtons({Key? key, required this.apiService}) : super(key: key);

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
            final bool isAnyOptionSelected = isSummarySelected && carniceriaState.optionsMap[carniceriaState.selectedProductType!]!.any((option) => option) ?? false;

            if (isCategorySelected && isScaleSelected && isPrinterSelected && isAnyOptionSelected) {
              carniceriaBloc.add(FetchProductList(
                carniceriaState.selectedProductType!,
                carniceriaState.isButchery,
                carniceriaState.summaries,
              ));

              carniceriaBloc.stream.firstWhere((state) => state.products.isNotEmpty).then((_) {
                final pesajeRepository = PesajeRepository(apiService: apiService);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(pesajeRepository: pesajeRepository),
                  ),
                );
              });
            } else {
              String errorMessage = AppLocalizations.of(context)!.selectItems;
              if (!isCategorySelected) errorMessage += '\n- ' + AppLocalizations.of(context)!.aCategory;
              if (!isScaleSelected) errorMessage += '\n- ' + AppLocalizations.of(context)!.aScale;
              if (!isPrinterSelected) errorMessage += '\n- ' + AppLocalizations.of(context)!.aPrinter;
              if (!isAnyOptionSelected) errorMessage += '\n- ' + AppLocalizations.of(context)!.atLeastOneSummary;

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.error,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      errorMessage,
                      style: TextStyle(fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.close,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          icon: Icon(Icons.check, color: Colors.black),
          label: Text(AppLocalizations.of(context)!.accept, style: TextStyle(color: Colors.black, fontSize: 27)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
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
