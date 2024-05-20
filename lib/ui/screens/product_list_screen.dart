import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';
import '../widgets/bottom_buttons_table.dart';
import '../widgets/product_list.dart';
import '../widgets/side_buttons.dart';
import '../../models/client.dart'; // Asegúrate de importar el modelo Client

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedClient;
  int? selectedRowIndex;
  List<Client> products = []; // Cambiar a List<Client>

  void _filterClient(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<CarniceriaBloc, CarniceriaState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text('Seleccionar Cliente'),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    var client = state.products[index].name;
                    return ListTile(
                      title: Row(
                        children: [
                          Icon(
                            selectedClient == client ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: selectedClient == client ? Colors.green : null,
                          ),
                          SizedBox(width: 10),
                          Text(client),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          selectedClient = client;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedClient = null;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Quitar Filtro'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _clearFilter() {
    setState(() {
      selectedClient = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CarniceriaBloc, CarniceriaState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return Center(child: Text('No hay productos disponibles'));
          }

          // No se necesita conversión si state.products ya es List<Client>
          List<Client> clients = state.products;

          return Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Expanded(flex: 5, child: ProductListTable(products: clients, selectedClient: selectedClient)),
                      Expanded(flex: 2, child: SideButtons(onFilterClient: () => _filterClient(context), onClearFilter: _clearFilter)),
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
