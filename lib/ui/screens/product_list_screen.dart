import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CarniceriaBloc, CarniceriaState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return Center(child: Text('No products available'));
          }

          return Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft, // Alinea la tabla en la parte superior izquierda
                  child: Row(
                    children: [
                      Expanded(flex: 5, child: ProductListTable(products: state.products)),
                      Expanded(flex: 2, child: SideButtons()),
                    ],
                  ),
                ),
              ),
              BottomButtons(),
            ],
          );
        },
      ),
    );
  }
}

class ProductListTable extends StatelessWidget {
  final List<dynamic> products;

  const ProductListTable({required this.products});

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];

    for (var product in products) {
      rows.add(
        DataRow(
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
          columnSpacing: 38.0,
          dataRowHeight: 70.0,
          headingRowHeight: 90.0,
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

class SideButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('REVISAR COMPLET', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('CANVIAR CONFIGURACIÓ', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('FILTRAR CLIENT', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('MARCAR PENDENT', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('PES PRODUCTE', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text('ENVIAR FINAL', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              minimumSize: Size(double.infinity, 60),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Multi Pes', style: TextStyle(color: Colors.black, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              minimumSize: Size(150, 60),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            child: Column(
              children: [
                Text('Aceptar Pesada,', style: TextStyle(color: Colors.black, fontSize: 18)),
                Text('gravar, imprimir', style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              minimumSize: Size(200, 60),
            ),
          ),
        ],
      ),
    );
  }
}
