import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterprova/ui/widgets/side_buttons_product_list/bottom_section.dart';
import 'package:flutterprova/ui/widgets/side_buttons_product_list/middle_buttons.dart';
import 'package:flutterprova/ui/widgets/side_buttons_product_list/top_buttons.dart';
import '../../data/repositories/pesaje_repository.dart';
import '../../models/client.dart';

class SideButtons extends StatelessWidget {
  final List<Client> products;
  final VoidCallback onFilterClient;
  final VoidCallback onClearFilter;
  final PesajeRepository pesajeRepository;
  final bool isFilterActive;

  const SideButtons({
    required this.products,
    required this.onFilterClient,
    required this.onClearFilter,
    required this.pesajeRepository,
    required this.isFilterActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopButtons(onReviewComplete: () => _showFunctionalityAlert(context)),
          const SizedBox(height: 50),
          MiddleButtons(
            isFilterActive: isFilterActive,
            onFilterClient: onFilterClient,
            onClearFilter: onClearFilter,
            products: products,
          ),
          const SizedBox(height: 50),
          const Spacer(),
          BottomSection(pesajeRepository: pesajeRepository, products: products),
        ],
      ),
    );
  }

  void _showFunctionalityAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.alert),
          content: Text(AppLocalizations.of(context)!.missingFunctionality),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
