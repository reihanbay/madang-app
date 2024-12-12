import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:madang_app/data/api/api_services.dart';
import 'package:madang_app/data/local/local_database_service.dart';
import 'package:madang_app/main.dart';
import 'package:madang_app/provider/bottom_nav_provider.dart';
import 'package:madang_app/provider/detail/detail_restaurant_provider.dart';
import 'package:madang_app/provider/favorite/favorites_provider.dart';
import 'package:madang_app/provider/home/list_restaurant_provider.dart';
import 'package:madang_app/provider/local_notifications_provider.dart';
import 'package:madang_app/provider/payload_provider.dart';
import 'package:madang_app/provider/settings/shared_preferences_provider.dart';
import 'package:madang_app/screen/favorite/favorite_screen.dart';
import 'package:madang_app/screen/home/home_screen.dart';
import 'package:madang_app/screen/settings/settings_screen.dart';
import 'package:madang_app/services/local_notification_service.dart';
import 'package:madang_app/services/shared_preferences_services.dart';
import 'package:madang_app/services/workmanager_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockBottomNavProvider extends Mock implements BottomNavProvider {}

void main() {
  late SharedPreferences preferences;
  late Widget widget;


  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    // final prefService =  SharedPreferencesServices(await SharedPreferences.getInstance());
    widget = MultiProvider(
      providers: [
        Provider(create: (context) => SharedPreferencesServices(preferences)),
        Provider(create: (context) => ApiServices(client: Client())),
        Provider(create: (context) => LocalDatabaseService()),
        Provider(create: (context) => WorkmanagerService()..init()),
        Provider(
            create: (context) => LocalNotificationService()
              ..init()
              ..configureLocalTimeZone()),
        ChangeNotifierProvider(
            create: (context) => LocalNotificationsProvider(
                context.read<LocalNotificationService>())),
        ChangeNotifierProvider(
            create: (context) => PayloadProvider(payload: "payload")),
        ChangeNotifierProvider(
            create: (context) => SharedPreferencesProvider(
                context.read<SharedPreferencesServices>())),
        ChangeNotifierProvider(
            create: (context) =>
                FavoritesProvider(context.read<LocalDatabaseService>())),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                ListRestaurantProvider(context.read<ApiServices>())),
        ChangeNotifierProvider(
            create: (context) =>
                DetailRestaurantProvider(context.read<ApiServices>())),
      ],
      child: const MaterialApp(home: MyApp(route: "/")),
    );
  });

  group("MainScreen Test", () {
    testWidgets("Checking All Component Widget", (tester) async {
      await tester.pumpWidget(widget);
      
      //checking
      final navBar = find.byType(NavigationBar);
      final destinations = find.descendant(
          of: navBar, matching: find.byType(NavigationDestination));
      final consumer = find.byType(Consumer<BottomNavProvider>);

      final homeNav = find.descendant(of: destinations, matching: find.text('Home'));
      final home =
          find.descendant(of: consumer, matching: find.byType(HomeScreen));


      final favorite =
          find.descendant(of: consumer, matching: find.byType(FavoriteScreen));
      final setting =
          find.descendant(of: consumer, matching: find.byType(SettingScreen));


      // Verify navbar
      expect(navBar, findsOneWidget);
      expect(destinations, findsWidgets);
      expect(homeNav, findsOneWidget);
      expect(consumer, findsOneWidget);

      // Verify initial screen is HomeScreen
      expect(find.text('Madang'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorite'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(home, findsOneWidget);
      expect(favorite, findsNothing);
      expect(setting, findsNothing);

      //action tap favorite
      await tester.tap(find.text('Favorite'));
      await tester.pumpAndSettle();

      expect(find.text('Favorite'), findsWidgets);
      expect(favorite, findsOneWidget);

      //action tap setting
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsWidgets);
      expect(setting, findsOneWidget);

      //action tap Home(back to home)
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsWidgets);
      expect(home, findsOneWidget);
      expect(favorite, findsNothing);
      expect(setting, findsNothing);
    });
  });
}
