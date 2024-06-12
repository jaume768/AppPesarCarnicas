import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/repositories/pesaje_repository.dart';
import '../../../../structure/bloc/pesaje/pesaje_bloc.dart';
import '../../../../structure/bloc/pesaje/pesaje_event.dart';
import '../../../../structure/bloc/pesaje/pesaje_state.dart';
import '../../../../structure/bloc/products/products_bloc.dart';
import '../../../../structure/bloc/products/products_event.dart';
import '../../../../structure/bloc/products/products_state.dart';
import '../../../utils/lot_number_modal.dart';
import 'multi_per_indicators.dart';
import '../../../../models/client.dart';
import 'custom_button.dart';

class BottomSection extends StatelessWidget {
  final PesajeRepository pesajeRepository;
  final List<Client> products;

  const BottomSection({super.key,
    required this.pesajeRepository,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMandatoryLotSection(context),
        const MultiPesIndicators(),
        _buildBottomButtons(context),
      ],
    );
  }

  Widget _buildMandatoryLotSection(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded && state.isMandatoryLot) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20, left: 165),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.lot, style: const TextStyle(color: Colors.black, fontSize: 24)),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _showLotNumberModal(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    minimumSize: const Size(100, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  child: Text(
                    state.lotNumber == 0 ? AppLocalizations.of(context)!.sn : state.lotNumber.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showLotNumberModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<ProductBloc>(context),
          child: const LotNumberModal(),
        );
      },
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          text: AppLocalizations.of(context)!.multiWeight,
          color: Colors.pink,
          width: 200,
          height: 100,
          fontSize: 24,
          onPressed: () {
            BlocProvider.of<PesajeBloc>(context).add(AccumulateWeight());
            BlocProvider.of<PesajeBloc>(context).add(IncrementCount());
          },
        ),
        BlocBuilder<PesajeBloc, PesajeState>(
          builder: (context, pesajeState) {
            return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, productState) {
                bool isWeightStable = pesajeState is PesajeLoaded &&
                    pesajeState.pesajeStatus['tipoPes'] != 'ZERO' &&
                    pesajeState.pesajeStatus['tipoPes'] != 'INESTABLE';

                bool isLotValid = productState is ProductLoaded &&
                    ((productState.isMandatoryLot && productState.lotNumber > 0) ||
                        !productState.isMandatoryLot);

                bool isPendingOrMarked = productState is ProductLoaded &&
                    (productState.pendingArticles.contains(productState.selectedArticle) ||
                        productState.acceptedArticles.contains(productState.selectedArticle) ||
                        products.any((product) =>
                            product.articles.any((article) =>
                            article.id == productState.selectedArticle && (article.isMarket || article.isAccepted))));

                bool isAcceptButtonEnabled = isWeightStable && isLotValid && !isPendingOrMarked;

                return CustomButton(
                  text: AppLocalizations.of(context)!.acceptWeightRecordPrint,
                  color: isAcceptButtonEnabled ? Colors.blueAccent : Colors.grey,
                  width: 250,
                  height: 100,
                  fontSize: 23,
                  onPressed: isAcceptButtonEnabled ? () async {
                    try {
                      await pesajeRepository.sendArticleWeight(
                          articleId: productState.selectedArticle,
                          weight: pesajeState.weight ?? 0.0,
                          accumulatedWeight: pesajeState.accumulatedWeight,
                          clientCode: productState.clientCode
                      );
                      BlocProvider.of<ProductBloc>(context).add(AcceptArticle(productState.selectedArticle, true));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(AppLocalizations.of(context)!.errorSendingWeight(e.toString()))),
                      );
                    }
                  } : null,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
