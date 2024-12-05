import 'package:flutter/material.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:madang_app/provider/favorite_icon_provider.dart';
import 'package:madang_app/screen/home/card_view_widget.dart';
import 'package:madang_app/screen/home/card_viewgrid_widget.dart';
import 'package:provider/provider.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
    required this.data,
    this.isShownFavorite = false
  });

  final List<Restaurants> data;
  final bool isShownFavorite;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = data[index];
          return ChangeNotifierProvider(create: (context) => FavoriteIconProvider(), child: CardView(item: item, isShownFavorite: isShownFavorite));
        });
  }
}

class RestaurantGrid extends StatelessWidget {
  final List<Restaurants> data;
  final int gridCount;
  final bool isShownFavorite;

  const RestaurantGrid(
      {super.key, required this.data, required this.gridCount, this.isShownFavorite = false});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: gridCount,
        children: data.map((item) {
          return CardViewGrid(item: item);
        }).toList());
  }
}