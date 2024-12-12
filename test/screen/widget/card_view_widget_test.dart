import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:madang_app/screen/widget/card_view_widget.dart';
import 'package:madang_app/static/nav_route.dart';

void main() {
  const key = Key("CardView");

  late Restaurants item;
  late Widget widget;
  late BuildContext context;

  setUp(() {
    item = Restaurants(
        id: "id",
        name: "name",
        description: "description",
        pictureId: "14",
        city: "city",
        rating: 4.0);
    widget = MaterialApp(
      home: Material(
        key: key,
        child: CardView(item: item),
      ),
    );
  });
  group('CardView Test', () {
    testWidgets('card view widget...', (tester) async {
      await tester.pumpWidget(widget);

      final inkWell = find.byType(InkWell);
      final card = find.byType(Card);
      final hero = find.byType(Hero);
      final cacheImage = find.byType(CachedNetworkImage);

      expect(inkWell, findsOneWidget);
      expect(card, findsOneWidget);
      expect(hero, findsOneWidget);
      expect(cacheImage, findsOneWidget);
    });

    testWidgets('InkWell test', (tester) async {
      await tester.pumpWidget(widget);

      final inkWellFinder = find.byType(InkWell);
      final inkWell = tester.widget<InkWell>(inkWellFinder);
      final card = find.byType(Card);
      final cardWidget = tester.widget<Card>(card);

      final borderRadius = BorderRadius.circular(16);

      expect(inkWell.borderRadius, borderRadius);
      expect(inkWell.child, cardWidget);
    });

    testWidgets('CardView test', (tester) async {
      await tester.pumpWidget(widget);
      context = tester.element(find.byType(MaterialApp));

      final card = find.byType(Card);
      final cardWidget = tester.widget<Card>(card);

      final color = Theme.of(context).colorScheme.onSecondary;
      final shadowColor =
          Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1);

      expect(cardWidget.color, color);
      expect(cardWidget.shadowColor, shadowColor);
    });

    testWidgets('Hero CachedImage Test', (tester) async {
      await tester.pumpWidget(widget);

      final hero = find.byType(Hero);
      final heroWidget = tester.widget<Hero>(hero);
      final cacheImage = find.byType(CachedNetworkImage);
      final cachedImageWidget = tester.widget<CachedNetworkImage>(cacheImage);

      expect(heroWidget.tag, item.pictureId);
      expect(heroWidget.child, cachedImageWidget);
      expect(cachedImageWidget.imageUrl,'https://restaurant-api.dicoding.dev/images/medium/${item.pictureId}');
    });
    testWidgets('Text Checking test', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.text(item.name), findsOneWidget);
      expect(find.text(item.city), findsOneWidget);
      expect(find.text(item.rating.toString()), findsOneWidget);
    });
    
  });
}
