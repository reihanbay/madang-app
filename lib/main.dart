import 'package:flutter/material.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/provider/detail_restaurant_provider.dart';
import 'package:madang_app/provider/list_restaurant_provider.dart';
import 'package:madang_app/screen/detail/detail_restaurant_screen.dart';
import 'package:madang_app/screen/home/home_screen.dart';
import 'package:madang_app/static/nav_route.dart';
import 'package:madang_app/style/util.dart';
import 'package:madang_app/style/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(create: (context) => ApiServices()),
    ChangeNotifierProvider(create: (context) => ListRestaurantProvider(context.read<ApiServices>())),
    ChangeNotifierProvider(create: (context) => DetailRestaurantProvider(context.read<ApiServices>()))
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Madang App',
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      initialRoute: NavRoute.home.route,
      routes: {
        NavRoute.home.route: (context) => const HomeScreen(),
        NavRoute.detailRestaurant.route: (context) => 
        DetailRestaurantScreen(id: ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}