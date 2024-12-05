import 'package:flutter/material.dart';
import 'package:madang_app/provider/favorite/favorites_provider.dart';
import 'package:madang_app/screen/widget/restaurant_list_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<FavoritesProvider>().getAllFavorite();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                alignment: Alignment.topLeft,
                child: Text("Favorite",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontSize: 32)),
              ),
              const SizedBox(height: 24),
              Consumer<FavoritesProvider>(
                  builder: (context, value, child) {
                    final list = value.list ??[];
                return switch(list.isNotEmpty) {
                  true => Flexible(
                        child: LayoutBuilder(builder: (context, constraint) {
                      if (constraint.maxWidth <= 600) {
                        return RestaurantList(data: list, isShownFavorite: true);
                      } else if (constraint.maxWidth <= 1200) {
                        return RestaurantGrid(data: list, gridCount: 3);
                      } else {
                        return RestaurantGrid(data: list, gridCount: 5);
                      }
                    })),
                  _ => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Empty Data Favorite")
                      ],
                    ),
                  )
                };
              }),
            ],
          ),
        ),
      );
  }
}