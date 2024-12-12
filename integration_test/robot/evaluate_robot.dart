import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madang_app/provider/bottom_nav_provider.dart';
import 'package:madang_app/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

class EvaluateRobot {
  final WidgetTester tester;

  EvaluateRobot(this.tester);
  final navBar = find.byType(NavigationBar);
  final consumer = find.byType(Consumer<BottomNavProvider>);


  Future<void> loadUI(Widget widget) async {
    await tester.pumpWidget(widget);
  }

  Future<void> tapHome() async {
    final nav =
        find.widgetWithText(NavigationDestination, 'Home');
    
    await tester.tap(nav);
    await tester.pumpAndSettle();
  }

   Future<void> tapFavorite() async {
    final nav =
        find.widgetWithText(NavigationDestination, 'Favorite');
    
    await tester.tap(nav);
    await tester.pumpAndSettle();
  }

  Future<void> tapSettings() async {
    final nav =
        find.widgetWithText(NavigationDestination, 'Settings');
    
    await tester.tap(nav);
    await tester.pumpAndSettle();
  }


  Future<void> dragHome() async {
    final home = find.descendant(of: consumer, matching: find.byType(HomeScreen));
  }
}
