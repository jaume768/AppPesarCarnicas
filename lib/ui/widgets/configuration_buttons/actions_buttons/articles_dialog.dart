import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../structure/bloc/article/article_bloc.dart';
import '../../../../structure/bloc/carniceria/carniceria_bloc.dart';
import 'sorting_button.dart';

void showArticlesDialog(BuildContext context) {
  final productType = context.read<CarniceriaBloc>().state.selectedProductType;
  if (productType != null) {
    context.read<ArticleBloc>().add(FetchArticles(productType: productType));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ArticleLoaded) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.viewTotalsByArticle),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SortingButton(context: context, text: 'Kgs', sortField: 'kgs', state: state),
                          SortingButton(context: context, text: 'Uni', sortField: 'units', state: state),
                          SortingButton(context: context, text: 'Caixes', sortField: 'boxes', state: state),
                          SortingButton(context: context, text: 'Doc', sortField: 'doc', state: state),
                        ],
                      ),
                      DataTable(
                        columns: [
                          DataColumn(label: Text('Codi')),
                          DataColumn(label: Text('Descripció')),
                          DataColumn(label: Text('Kgs')),
                          DataColumn(label: Text('Uni')),
                          DataColumn(label: Text('Caixes')),
                          DataColumn(label: Text('Doc')),
                        ],
                        rows: state.sortedArticles.map((article) {
                          return DataRow(cells: [
                            DataCell(Text(article['code'].toString())),
                            DataCell(Text(article['description'])),
                            DataCell(Text(article['kgs'].toString())),
                            DataCell(Text(article['units'].toString())),
                            DataCell(Text(article['boxes'].toString())),
                            DataCell(Text(article['doc'].toString())),
                          ]);
                        }).toList(),
                        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
                        border: TableBorder.all(color: Colors.black, width: 1.0),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.close),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              );
            } else {
              return _errorDialog(context, state);
            }
          },
        );
      },
    );
  } else {
    _showCategoryErrorDialog(context);
  }
}

AlertDialog _errorDialog(BuildContext context, ArticleState state) {
  return AlertDialog(
    title: Text(AppLocalizations.of(context)!.error),
    content: Text(state is ArticleError ? state.message : 'Error desconocido'),
    actions: [
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(AppLocalizations.of(context)!.close),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
    ],
  );
}

void _showCategoryErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(AppLocalizations.of(context)!.selectCategory),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.close),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      );
    },
  );
}
