import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/products/products_bloc.dart';
import '../../structure/bloc/products/products_event.dart';
import '../../structure/bloc/products/products_state.dart';
import '../../models/client.dart';

class ProductListTable extends StatelessWidget {
  final List<Client> products;
  final String? selectedClient;

  const ProductListTable({Key? key, required this.products, this.selectedClient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          List<DataRow> rows = [];
          int rowIndex = 0;

          for (var product in products) {
            if (selectedClient != null && product.name != selectedClient) continue;

            rows.add(
              DataRow(
                cells: [
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('${product.name} (${product.code})', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
                ],
              ),
            );

            rowIndex++;  // Incrementar rowIndex para cada nuevo producto

            // Agregamos las filas de los artículos (con selección)
            for (var article in product.articles) {
              int currentRowIndex = rowIndex;
              rows.add(
                DataRow(
                  selected: state.selectedArticles.contains(currentRowIndex),
                  onSelectChanged: (selected) {
                    if (selected == true) {
                      BlocProvider.of<ProductBloc>(context).add(SelectArticle(currentRowIndex));
                    } else {
                      BlocProvider.of<ProductBloc>(context).add(DeselectArticle(currentRowIndex));
                    }
                  },
                  cells: [
                    DataCell(Text(' ', style: TextStyle(color: Colors.black, fontSize: 18))),
                    DataCell(Text(article.units.toString(), style: TextStyle(color: Colors.black, fontSize: 18))),
                    DataCell(Text(article.unitType, style: TextStyle(color: Colors.black, fontSize: 18))),
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.name, style: TextStyle(color: Colors.black, fontSize: 18)),
                        Text(article.observation, style: TextStyle(color: Colors.black, fontSize: 18)),
                      ],
                    )),
                  ],
                ),
              );
              rowIndex++;
            }
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 58.0,
              dataRowHeight: 80.0,
              headingRowHeight: 120.0,
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.black, width: 2),
                verticalInside: BorderSide(color: Colors.black, width: 2),
                right: BorderSide(color: Colors.black, width: 2),
                bottom: BorderSide(color: Colors.black, width: 2),
                top: BorderSide(color: Colors.black, width: 2),
                left: BorderSide(color: Colors.black, width: 2),
              ),
              columns: [
                DataColumn(label: Text('BLOC', style: TextStyle(color: Colors.black, fontSize: 20))),
                DataColumn(label: Text('QUANT.', style: TextStyle(color: Colors.black, fontSize: 20))),
                DataColumn(label: Text('UNI', style: TextStyle(color: Colors.black, fontSize: 20))),
                DataColumn(label: Text('CLIENT/ PRODUCTE', style: TextStyle(color: Colors.black, fontSize: 20))),
              ],
              rows: rows,
            ),
          );
        } else {
          return Center(child: Text('No se han cargado los productos'));
        }
      },
    );
  }
}
