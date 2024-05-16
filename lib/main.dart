import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterprova/structure/bloc/carniceria/carniceria_bloc.dart';
import 'package:flutterprova/ui/screens/carniceria_screen.dart';

import 'data/repositories/carniceria_repository.dart';
import 'data/services/api_service.dart';

void main() {
  final apiService = ApiService(baseUrl: 'http://10.0.2.2:3000');
  final carniceriaRepository = CarniceriaRepository(apiService: apiService);

  runApp(MyApp(repository: carniceriaRepository));
}

class MyApp extends StatelessWidget {
  final CarniceriaRepository repository;

  MyApp({required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CarniceriaBloc(repository: repository),
        ),
      ],
      child: MaterialApp(
        title: 'Carnicería',
        home: CarniceriaScreen(),
      ),
    );
  }
}


