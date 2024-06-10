import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/pesaje_repository.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';
import '../widgets/product_list.dart';
import '../widgets/side_buttons.dart';
import '../../models/client.dart';

class ProductListScreen extends StatefulWidget {
  final PesajeRepository pesajeRepository;

  const ProductListScreen({Key? key, required this.pesajeRepository}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedClient;
  int? selectedRowIndex;
  List<Client> products = [];
  String filter = '';
  TextEditingController _searchController = TextEditingController();

  void _filterClient(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<CarniceriaBloc, CarniceriaState>(
          builder: (context, state) {
            List<Client> filteredClients = state.products
                .where((client) => client.name.toLowerCase().contains(filter.toLowerCase()))
                .toList();

            return AlertDialog(
              title: Text('Seleccionar Cliente'),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Buscar Cliente',
                      ),
                      onChanged: (value) {
                        setState(() {
                          filter = value;
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredClients.length,
                        itemBuilder: (BuildContext context, int index) {
                          var client = filteredClients[index].name;
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
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedClient = null;
                      filter = '';
                      _searchController.clear();
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
      filter = '';
      _searchController.clear();
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

          return Column(
            children: [
              SizedBox(height: 70.0),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: ProductListTable(
                          products: state.products,
                          selectedClient: selectedClient,
                          pesajeRepository: widget.pesajeRepository,
                        ),
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      flex: 4,
                      child: SideButtons(
                        products: state.products,
                        onFilterClient: () => _filterClient(context),
                        onClearFilter: _clearFilter,
                        pesajeRepository: widget.pesajeRepository,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
