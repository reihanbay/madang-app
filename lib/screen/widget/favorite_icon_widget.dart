import 'package:flutter/material.dart';
import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/provider/detail/detail_restaurant_provider.dart';
import 'package:madang_app/provider/favorite/favorites_provider.dart';
import 'package:madang_app/provider/favorite_icon_provider.dart';
import 'package:madang_app/static/detail_result_state.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatefulWidget {
  final String id;
  final Restaurant? inDetail;
  const FavoriteWidget({super.key, required this.id, this.inDetail});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool stateFavorite = false;
  @override
  void initState() {
    final favoriteProvider = context.read<FavoritesProvider>();
    final iconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await favoriteProvider.getDetailRestaurant(widget.id);

      final value = favoriteProvider.checkItemBookmark(widget.id);
      iconProvider.isFavorite = value;
    });
    super.initState();
  }

  void savingFavorite() async {
    final favoriteProvider = context.read<FavoritesProvider>();
    final iconProvider = context.read<FavoriteIconProvider>();

    if (widget.inDetail == null) {
      final restaurantsProvider = context.read<DetailRestaurantProvider>();
      await restaurantsProvider.fetchDetailRestaurant(widget.id);
    }

    switch (Provider.of<DetailRestaurantProvider>(context, listen: false)
        .resultDetail) {
      case DetailResultLoadedState(item: var data):
        if (!iconProvider.isFavorite) {
          favoriteProvider.setRestaurant(data);
        } else {
          favoriteProvider.removeFavorite(widget.id);
        }
        if (widget.id == data.id) iconProvider.isFavorite = !iconProvider.isFavorite;
        favoriteProvider.getAllFavorite();
      case DetailResultErrorState(error: var message):
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: savingFavorite,
      child: Icon(context.watch<FavoriteIconProvider>().isFavorite ? Icons.favorite : Icons.favorite_outline),
    );
  }
}
