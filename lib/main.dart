import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutterprova/data/repositories/carniceria_repository.dart';
import 'package:flutterprova/data/repositories/configuration_repository.dart';
import 'package:flutterprova/data/repositories/pesaje_repository.dart';
import 'package:flutterprova/data/repositories/product_repository.dart';
import 'package:flutterprova/data/services/api_service.dart';
import 'package:flutterprova/structure/bloc/article/article_bloc.dart';
import 'package:flutterprova/structure/bloc/carniceria/carniceria_bloc.dart';
import 'package:flutterprova/structure/bloc/configuration/configuration_bloc.dart';
import 'package:flutterprova/structure/bloc/locale_bloc/locale_bloc.dart';
import 'package:flutterprova/structure/bloc/pesaje/pesaje_bloc.dart';
import 'package:flutterprova/structure/bloc/products/products_bloc.dart';
import 'package:flutterprova/ui/screens/configuration_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  final apiService = ApiService(baseUrl: dotenv.env['BASE_URL']!);
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
          create: (context) => ArticleBloc(productRepository: productRepository),
        ),
        BlocProvider<LocaleBloc>(
          create: (context) => LocaleBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Carnisseria',
        debugShowCheckedModeBanner: false,
        locale: Locale('ca', 'ES'),
        supportedLocales: [
          Locale('ca', 'ES'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CarniceriaScreen(),
      ),
    );
  }
}
