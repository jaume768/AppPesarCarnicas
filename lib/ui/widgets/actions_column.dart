import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/configuration/configuration_bloc.dart';
import '../../structure/bloc/configuration/configuration_event.dart';
import '../../structure/bloc/configuration/configuration_state.dart';
import '../../structure/bloc/article/article_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';

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
                'Seleccionar Báscula',
                state.selectedScale != null ? 'Seleccionada: ${state.selectedScale['name']}' : 'Seleccionar Báscula',
                Colors.lightBlue,
                true,
                null,
              ),
              SizedBox(height: 10),
              _buildButton(
                context,
                'Seleccionar Impresora',
                state.selectedPrinter != null ? 'Seleccionada: ${state.selectedPrinter['name']}' : 'Seleccionar Impresora',
                Colors.pink,
                false,
                null,
              ),
              SizedBox(height: 10),
              _buildButton(
                context,
                'Veure Totals x Article',
                'Veure Totals x Article',
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
      width: 190,
      height: 190, // Altura fija para los botones
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: color,
          minimumSize: Size(0, 0), // Tamaño mínimo 0 para asegurar el cuadrado
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
            style: TextStyle(fontSize: 22), // Ajusta el tamaño del texto según sea necesario
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
              title: Text(isScale ? 'Seleccionar Báscula' : 'Seleccionar Impresora'),
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
                  title: Text('Veure Totals x Article'),
                  content: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Codi')),
                        DataColumn(label: Text('Descripció')),
                        DataColumn(label: Text('Kgs')),
                        DataColumn(label: Text('Uni')),
                        DataColumn(label: Text('Caixes')),
                        DataColumn(label: Text('Doc')),
                      ],
                      rows: state.articles.map((article) {
                        return DataRow(cells: [
                          DataCell(Text(article['code'].toString())),
                          DataCell(Text(article['description'])),
                          DataCell(Text(article['kgs'].toString())),
                          DataCell(Text(article['units'].toString())),
                          DataCell(Text(article['boxes'].toString())),
                          DataCell(Text(article['doc'].toString())),
                        ]);
                      }).toList(),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cerrar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ],
                );
              } else if (state is ArticleError) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(state.message),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cerrar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Seleccione un tipo de producto primero')));
    }
  }
}
