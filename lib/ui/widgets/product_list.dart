import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductListTable extends StatelessWidget {
  final List<dynamic> products;

  const ProductListTable({required this.products});

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];

    for (var product in products) {
      rows.add(
        DataRow(
          color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
            return Colors.grey[300]; // Color de fondo para las filas de nombre y código del producto
          }),
          cells: [
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('${product['name']} (${product['code']})', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
          ],
        ),
      );

      for (var article in product['articles']) {
        rows.add(
          DataRow(
            cells: [
              DataCell(Text(article['bloc']?.toString() ?? '', style: TextStyle(color: Colors.black, fontSize: 18))),
              DataCell(Text(article['units']?.toString() ?? '', style: TextStyle(color: Colors.black, fontSize: 18))),
              DataCell(Text(article['unitType']?.toString() ?? '', style: TextStyle(color: Colors.black, fontSize: 18))),
              DataCell(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article['name']?.toString() ?? '', style: TextStyle(color: Colors.black, fontSize: 18)),
                  Text(article['observation']?.toString() ?? '', style: TextStyle(color: Colors.black, fontSize: 18)),
                ],
              )),
            ],
          ),
        );
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
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
      ),
    );
  }
}