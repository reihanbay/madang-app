import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:madang_app/data/model/restaurant_list_response.dart';
import 'package:madang_app/static/nav_route.dart';

class CardView extends StatelessWidget {
  final Restaurant item;
  const CardView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.pushNamed(context, NavRoute.detailRestaurant.route,
              arguments: item.id);
        },
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          shadowColor:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: item.pictureId,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://restaurant-api.dicoding.dev/images/medium/${item.pictureId}',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500)),
                        Text(item.city,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24),
                            const SizedBox(width: 2),
                            Text(item.rating.toString(),
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.favorite_outline),
                )
              ],
            ),
          ),
        ));
  }
}
