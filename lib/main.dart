import 'package:flutter/material.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/provider/bottom_nav_provider.dart';
import 'package:madang_app/provider/detail/detail_restaurant_provider.dart';
import 'package:madang_app/provider/home/list_restaurant_provider.dart';
import 'package:madang_app/provider/shared_preferences_provider.dart';
import 'package:madang_app/screen/detail/detail_restaurant_screen.dart';
import 'package:madang_app/screen/favorite/favorite_screen.dart';
import 'package:madang_app/screen/home/home_screen.dart';
import 'package:madang_app/screen/main_screen.dart';
import 'package:madang_app/screen/settings/settings_screen.dart';
import 'package:madang_app/services/shared_preferences_services.dart';
import 'package:madang_app/static/nav_route.dart';
import 'package:madang_app/style/util.dart';
import 'package:madang_app/style/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(providers: [
    Provider(create: (context) => SharedPreferencesServices(prefs)),
    Provider(create: (context) => ApiServices()),
    ChangeNotifierProvider(
        create: (context) => SharedPreferencesProvider(
            context.read<SharedPreferencesServices>())),
    ChangeNotifierProvider(create: (context) => BottomNavProvider()),
    ChangeNotifierProvider(
        create: (context) =>
            ListRestaurantProvider(context.read<ApiServices>())),
    ChangeNotifierProvider(
        create: (context) =>
            DetailRestaurantProvider(context.read<ApiServices>()))
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      final sharedPrefProvider = context.read<SharedPreferencesProvider>();

     Future.microtask(() async {
      sharedPrefProvider.getTheme();
    });
  }
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Madang App',
      darkTheme: theme.dark(),
      themeMode: context.watch<SharedPreferencesProvider>().theme ? ThemeMode.dark : ThemeMode.light,
      theme: theme.light(),
      initialRoute: NavRoute.main.route,
      routes: {
        NavRoute.main.route: (context) => const MainScreen(),
        NavRoute.home.route: (context) => const HomeScreen(),
        NavRoute.favorite.route: (context) => const FavoriteScreen(),
        NavRoute.setting.route: (context) => const SettingScreen(),
        NavRoute.detailRestaurant.route: (context) => DetailRestaurantScreen(
            id: ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}
