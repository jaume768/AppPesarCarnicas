import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../structure/bloc/products/products_bloc.dart';
import '../../../../structure/bloc/products/products_event.dart';
import '../../../../structure/bloc/products/products_state.dart';
import 'custom_button.dart';
import '../../../../models/client.dart';

class MiddleButtons extends StatelessWidget {
  final bool isFilterActive;
  final VoidCallback onFilterClient;
  final VoidCallback onClearFilter;
  final List<Client> products;

  const MiddleButtons({
    required this.isFilterActive,
    required this.onFilterClient,
    required this.onClearFilter,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CustomButton(
            text: isFilterActive ? AppLocalizations.of(context)!.removeFilter : AppLocalizations.of(context)!.filterClient,
            color: Colors.green.shade300,
            onPressed: isFilterActive ? onClearFilter : onFilterClient,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMarkAsPendingButton(context),
        ),
        Expanded(
          child: _buildBlocButton(context),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildMarkAsPendingButton(BuildContext context) {
    return CustomButton(
      text: AppLocalizations.of(context)!.markPending,
      color: Colors.grey.shade300,
      onPressed: () {
        final currentState = BlocProvider.of<ProductBloc>(context).state;
        if (currentState is ProductLoaded) {
          for (var product in products) {
            for (var articulo in product.articles) {
              if (articulo.isMarket && currentState.selectedArticle == articulo.code) {
                articulo.isMarket = false;
                BlocProvider.of<ProductBloc>(context).add(MarkAsPending(currentState.selectedArticle, false));
                return;
              }
            }
          }
        }
        BlocProvider.of<ProductBloc>(context).add(MarkAsPending(currentState.selectedArticle, true));
      },
    );
  }

  Widget _buildBlocButton(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final buttonText = (state is ProductLoaded && state.isSpecial) ? AppLocalizations.of(context)!.blockLabel : AppLocalizations.of(context)!.productWeight;
        return CustomButton(
          text: buttonText,
          color: Colors.orange,
          onPressed: () {
            final productState = BlocProvider.of<ProductBloc>(context).state;
            if (productState is ProductLoaded) {
              BlocProvider.of<ProductBloc>(context).add(AcceptArticle(productState.selectedArticle, true));
            }
          },
        );
      },
    );
  }
}
