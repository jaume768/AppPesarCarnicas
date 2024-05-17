import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: BlocBuilder<CarniceriaBloc, CarniceriaState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return Center(child: Text('No products available'));
          }

          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final client = state.products[index];
              return ListTile(
                title: Text(client['name']),
                subtitle: Text('Code: ${client['code']}'),
                onTap: () {
                  // Handle tap on product if needed
                },
              );
            },
          );
        },
      ),
    );
  }
}
