import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterprova/structure/bloc/carniceria/carniceria_bloc.dart';
import 'package:flutterprova/structure/bloc/configuration/configuration_bloc.dart';
import 'package:flutterprova/structure/bloc/products/products_bloc.dart';
import 'package:flutterprova/structure/bloc/pesaje/pesaje_bloc.dart';
import 'package:flutterprova/structure/bloc/article/article_bloc.dart';
import 'package:flutterprova/ui/screens/carniceria_screen.dart';
import 'data/repositories/carniceria_repository.dart';
import 'data/repositories/configuration_repository.dart';
import 'data/repositories/product_repository.dart';
import 'data/repositories/pesaje_repository.dart';
import 'data/services/api_service.dart';

void main() {
  final apiService = ApiService(baseUrl: 'http://10.0.2.2:3000');
  final carniceriaRepository = CarniceriaRepository(apiService: apiService);
  final configurationRepository = ConfigurationRepository(apiService: apiService);
  final productRepository = ProductRepository(apiService: apiService);
  final pesajeRepository = PesajeRepository(apiService: apiService);

  runApp(MyApp(
    carniceriaRepository: carniceriaRepository,
    configurationRepository: configurationRepository,
    productRepository: productRepository,
    pesajeRepository: pesajeRepository,
  ));
}

class MyApp extends StatelessWidget {
  final CarniceriaRepository carniceriaRepository;
  final ConfigurationRepository configurationRepository;
  final ProductRepository productRepository;
  final PesajeRepository pesajeRepository;

  MyApp({
    required this.carniceriaRepository,
    required this.configurationRepository,
    required this.productRepository,
    required this.pesajeRepository,
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
        BlocProvider<PesajeBloc>(
          create: (context) => PesajeBloc(repository: pesajeRepository),
        ),
        BlocProvider<ArticleBloc>(
          create: (context) => ArticleBloc(productRepository: productRepository), // Añadir el ArticleBloc
        ),
      ],
      child: MaterialApp(
        title: 'Carnicería',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CarniceriaScreen(),
      ),
    );
  }
}
