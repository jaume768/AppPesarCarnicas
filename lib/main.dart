import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterprova/structure/bloc/carniceria/carniceria_bloc.dart';
import 'package:flutterprova/ui/screens/carniceria_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carnicería',
      home: BlocProvider(
        create: (context) => CarniceriaBloc(),
        child: CarniceriaScreen(),
      ),
    );
  }
}


