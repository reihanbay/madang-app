import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
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
import 'package:madang_app/static/nav_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'robot/evaluate_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
  });
  testWidgets("Integrated All", (tester) async {
    final initBot = EvaluateRobot(tester);

    //loadUi
    await initBot.loadUI(MultiProvider(providers: [
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
    ], child: MyApp(route: NavRoute.main.route)));

    //home
    await initBot.tapHome();

    //favorite
    await initBot.tapFavorite();

    //settings
    await initBot.tapSettings();

    await initBot.tapHome();

  });
}
