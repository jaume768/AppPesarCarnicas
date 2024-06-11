import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../structure/bloc/configuration/configuration_bloc.dart';
import '../../structure/bloc/configuration/configuration_event.dart';
import '../../structure/bloc/configuration/configuration_state.dart';
import '../../structure/bloc/article/article_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';

class ActionsColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ConfigurationBloc, ConfigurationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              _buildButton(
                context,
                AppLocalizations.of(context)!.selectScale,
                state.selectedScale != null
                    ? AppLocalizations.of(context)!.scaleSelected(state.selectedScale['name'])
                    : AppLocalizations.of(context)!.selectScale,
                Colors.lightBlue,
                true,
                null,
              ),
              SizedBox(height: 10),
              _buildButton(
                context,
                AppLocalizations.of(context)!.selectPrinter,
                state.selectedPrinter != null
                    ? AppLocalizations.of(context)!.printerSelected(state.selectedPrinter['name'])
                    : AppLocalizations.of(context)!.selectPrinter,
                Colors.pink,
                false,
                null,
              ),
              SizedBox(height: 10),
              _buildButton(
                context,
                AppLocalizations.of(context)!.viewTotalsByArticle,
                AppLocalizations.of(context)!.viewTotalsByArticle,
                Colors.red,
                null,
                    () => _showArticlesDialog(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String displayText, Color color, bool? isScale, VoidCallback? onPressed) {
    return Container(
      width: 182,
      height: 182, // Fixed height for buttons
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(0, 0), // Minimum size to 0 to ensure it's square
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: onPressed ?? () {
          if (isScale != null) {
            _showSelectionDialog(context, isScale);
          }
        },
        child: Center(
          child: Text(
            displayText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21), // Adjust text size as needed
          ),
        ),
      ),
    );
  }

  void _showSelectionDialog(BuildContext context, bool isScale) {
    context.read<ConfigurationBloc>().add(FetchConfiguration());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ConfigurationBloc, ConfigurationState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            final items = isScale ? state.scales : state.printers;
            return AlertDialog(
              title: Text(isScale ? AppLocalizations.of(context)!.selectScale : AppLocalizations.of(context)!.selectPrinter),
              content: SingleChildScrollView(
                child: ListBody(
                  children: items.map((item) {
                    return ListTile(
                      title: Text(item['name']),
                      onTap: () {
                        if (isScale) {
                          context.read<ConfigurationBloc>().add(SelectScale(item));
                        } else {
                          context.read<ConfigurationBloc>().add(SelectPrinter(item));
                        }
                        Navigator.of(context).pop();
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showArticlesDialog(BuildContext context) {
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
                            _sortingButton(context, 'Kgs', 'kgs', state),
                            _sortingButton(context, 'Uni', 'units', state),
                            _sortingButton(context, 'Caixes', 'boxes', state),
                            _sortingButton(context, 'Doc', 'doc', state),
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

  Widget _sortingButton(BuildContext context, String text, String sortField, ArticleLoaded state) {
    bool isActive = state.sortField == sortField;
    bool isAscending = isActive ? state.isAscending : false;

    return ElevatedButton(
      onPressed: () {
        bool newAscending = isActive ? !state.isAscending : false;
        context.read<ArticleBloc>().add(SortArticles(sortField: sortField, isAscending: newAscending));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.blue : Colors.grey,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        elevation: isActive ? 4 : 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          Icon(
            isAscending ? Icons.arrow_upward : Icons.arrow_downward,
            size: 16,
            color: Colors.white,
          ),
        ],
      ),
    );
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
}
