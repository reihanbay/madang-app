import 'package:flutter/material.dart';
import 'package:madang_app/provider/bottom_nav_provider.dart';
import 'package:madang_app/provider/payload_provider.dart';
import 'package:madang_app/screen/favorite/favorite_screen.dart';
import 'package:madang_app/screen/home/home_screen.dart';
import 'package:madang_app/screen/settings/settings_screen.dart';
import 'package:madang_app/services/local_notification_service.dart';
import 'package:madang_app/static/nav_route.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) {
      if (mounted) {
        context.read<PayloadProvider>().payload = payload;
        Navigator.pushNamed(context, NavRoute.detailRestaurant.route, arguments: payload);
      }
    });
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  void initState() {
    configureSelectNotificationSubject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
            onDestinationSelected: (value) {
              context.read<BottomNavProvider>().setIndexBottomNav = value;
            },
            selectedIndex: context.watch<BottomNavProvider>().indexBottomNav,
            destinations: const [
              NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: "Home"),
              NavigationDestination(
                  selectedIcon: Icon(Icons.favorite),
                  icon: Icon(Icons.favorite_border_outlined),
                  label: "Favorite"),
              NavigationDestination(
                  selectedIcon: Icon(Icons.settings),
                  icon: Icon(Icons.settings_outlined),
                  label: "Settings"),
            ]),
        body: Consumer<BottomNavProvider>(builder: (context, value, child) {
          return <Widget>[
            const HomeScreen(),
            const FavoriteScreen(),
            const SettingScreen(),
          ][value.indexBottomNav];
        }));
  }
}
