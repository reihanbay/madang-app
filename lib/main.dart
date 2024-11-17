import 'package:flutter/material.dart';
import 'package:madang_app/screen/detail_restaurant.dart';
import 'package:madang_app/screen/home/home_screen.dart';
import 'package:madang_app/static/nav_route.dart';
import 'package:madang_app/style/util.dart';
import 'package:madang_app/style/theme/theme.dart';

void main() {
  runApp(const MyApp());
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
      initialRoute: NavRoute.detailRestaurant.route,
      routes: {
        NavRoute.home.route: (context) => const HomeScreen(),
        NavRoute.detailRestaurant.route: (context) => const DetailRestaurantScreen()
      },
    );
  }
}