import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterprova/structure/bloc/carniceria/carniceria_bloc.dart';
import 'package:flutterprova/structure/bloc/configuration/configuration_bloc.dart';
import 'package:flutterprova/structure/bloc/products/products_bloc.dart';
import 'package:flutterprova/ui/screens/carniceria_screen.dart';
import 'data/repositories/carniceria_repository.dart';
import 'data/repositories/configuration_repository.dart';
import 'data/repositories/product_repository.dart';
import 'data/services/api_service.dart';

void main() {
  final apiService = ApiService(baseUrl: 'http://10.0.2.2:3000');
  final carniceriaRepository = CarniceriaRepository(apiService: apiService);
  final configurationRepository = ConfigurationRepository(apiService: apiService);
  final productRepository = ProductRepository(apiService: apiService); // Asegurarse de inicializar el ProductRepository

  runApp(MyApp(
    carniceriaRepository: carniceriaRepository,
    configurationRepository: configurationRepository,
    productRepository: productRepository, // Pasar el ProductRepository al constructor de MyApp
  ));
}

class MyApp extends StatelessWidget {
  final CarniceriaRepository carniceriaRepository;
  final ConfigurationRepository configurationRepository;
  final ProductRepository productRepository;

  MyApp({
    required this.carniceriaRepository,
    required this.configurationRepository,
    required this.productRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(repository: productRepository),
        ),
        BlocProvider<CarniceriaBloc>(
          create: (context) => CarniceriaBloc(repository: carniceriaRepository),
        ),
        BlocProvider<ConfigurationBloc>(
          create: (context) => ConfigurationBloc(repository: configurationRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Carnicería',
        theme: ThemeData(
          primarySwatch: Colors.blue, // Puedes definir un tema global aquí
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CarniceriaScreen(),
      ),
    );
  }
}
