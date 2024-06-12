import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/repositories/pesaje_repository.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';
import '../widgets/product_list_buttons/product_list.dart';
import '../widgets/product_list_buttons/side_buttons.dart';
import '../../models/client.dart';

class ProductListScreen extends StatefulWidget {
  final PesajeRepository pesajeRepository;

  const ProductListScreen({super.key, required this.pesajeRepository});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedClient;
  int? selectedRowIndex;
  List<Client> products = [];
  String filter = '';
  final TextEditingController _searchController = TextEditingController();

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
              title: Text(AppLocalizations.of(context)!.selectClient),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.searchClient,
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
                                const SizedBox(width: 10),
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
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
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
            return Center(child: Text(AppLocalizations.of(context)!.noProductsAvailable));
          }

          return Column(
            children: [
              const SizedBox(height: 70.0),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: ProductListTable(
                          products: state.products,
                          selectedClient: selectedClient,
                          pesajeRepository: widget.pesajeRepository,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 4,
                      child: SideButtons(
                        products: state.products,
                        onFilterClient: () => _filterClient(context),
                        onClearFilter: _clearFilter,
                        pesajeRepository: widget.pesajeRepository,
                        isFilterActive: selectedClient != null,
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

