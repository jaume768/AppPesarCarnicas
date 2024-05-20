import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_bloc.dart';
import '../../structure/bloc/carniceria/carniceria_state.dart';
import '../widgets/bottom_buttons_table.dart';
import '../widgets/product_list.dart';
import '../widgets/side_buttons.dart';

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





