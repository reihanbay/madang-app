import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madang_app/data/model/restaurant_detail_response.dart';
import 'package:madang_app/screen/widget/favorite_icon_widget.dart';

class BodyDetailWidget extends StatelessWidget {
  final Restaurant dataDetail;
  const BodyDetailWidget({super.key, required this.dataDetail});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 840) {
        return DetailWebPage(dataDetail: dataDetail);
      } else {
        return DetailMobilePage(dataDetail: dataDetail);
      }
    });
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    super.key,
    required this.dataDetail,
    required this.context,
    required this.url,
    required this.flagMenu,
  });

  final Restaurant dataDetail;
  final BuildContext context;
  final String url;
  final String flagMenu;

  @override
  Widget build(BuildContext context) {
    String label = "";
    List<Category> list = [];
    if (flagMenu == 'foods') {
      label = "Makanan";
      list = dataDetail.menus.foods;
    } else if (flagMenu == 'drinks') {
      label = "Minuman";
      list = dataDetail.menus.drinks;
    }
    menu() {
      return list.map((menu) => Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary),
          child: Text(menu.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary))));
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Menu",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          ...menu()
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary),
            child: SvgPicture.asset(url, width: 24, height: 24),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}

class ItemReview extends StatelessWidget {
  const ItemReview({
    super.key,
    required this.context,
    required this.item,
  });

  final BuildContext context;
  final CustomerReview item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(item.name,
                    style: Theme.of(context).textTheme.bodyMedium)),
            Text(item.date, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 6),
        Text(item.review,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.secondary)),
        const SizedBox(height: 12, child: Divider(height: 1, thickness: 1)),
      ],
    );
  }
}

class DetailMobilePage extends StatelessWidget {
  final Restaurant dataDetail;
  const DetailMobilePage({super.key, required this.dataDetail});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: dataDetail.pictureId,
              child: Container(
                constraints: const BoxConstraints(
                    minWidth: 360, maxWidth: double.infinity, minHeight: 412),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(24)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            "https://restaurant-api.dicoding.dev/images/medium/${dataDetail.pictureId}"))),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dataDetail.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w500)),
                            Text(dataDetail.city,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ),
                      Flexible(
                          child: FavoriteWidget(
                        id: dataDetail.id,
                        inDetail: dataDetail,
                      ))
                    ],
                  ),
                  const SizedBox.square(
                    dimension: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber[400],
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                          child: Text(dataDetail.rating.toString(),
                              style: Theme.of(context).textTheme.bodyMedium)),
                      const SizedBox(width: 2),
                      Expanded(
                          child: Text(
                              "(${dataDetail.customerReviews.length} Reviews)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w300))),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: dataDetail.categories
                        .map((category) => Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer),
                            child: Text(category.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary))))
                        .toList(),
                  ),
                  const SizedBox.square(dimension: 24),
                  Text("Deskripsi",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox.square(dimension: 8),
                  Text(dataDetail.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify),
                  const SizedBox.square(dimension: 24),
                  Text("Menu",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ItemMenu(
                          dataDetail: dataDetail,
                          context: context,
                          url: 'assets/food_icon.svg',
                          flagMenu: 'foods'),
                      const SizedBox(width: 16),
                      ItemMenu(
                          dataDetail: dataDetail,
                          context: context,
                          url: 'assets/drink_icon.svg',
                          flagMenu: 'drinks'),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text("Reviews",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500)),
            ),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 100),
              margin: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: dataDetail.customerReviews.reversed
                      .map((item) => ItemReview(context: context, item: item))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailWebPage extends StatelessWidget {
  final Restaurant dataDetail;
  const DetailWebPage({super.key, required this.dataDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Hero(
            tag: dataDetail.pictureId,
            child: Container(
              constraints: const BoxConstraints(
                  minWidth: 360, maxWidth: double.infinity, minHeight: 412),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(24)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                          "https://restaurant-api.dicoding.dev/images/medium/${dataDetail.pictureId}"))),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(dataDetail.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w500)),
                              Text(dataDetail.city,
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ),
                        Flexible(
                            child: FavoriteWidget(
                          id: dataDetail.id,
                          inDetail: dataDetail,
                        ))
                      ],
                    ),
                    const SizedBox.square(
                      dimension: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber[400],
                        ),
                        const SizedBox(width: 2),
                        Flexible(
                            child: Text(dataDetail.rating.toString(),
                                style: Theme.of(context).textTheme.bodyMedium)),
                        const SizedBox(width: 2),
                        Expanded(
                            child: Text(
                                "(${dataDetail.customerReviews.length} Reviews)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w300))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: dataDetail.categories
                          .map((category) => Container(
                              padding: const EdgeInsets.all(6),
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer),
                              child: Text(category.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary))))
                          .toList(),
                    ),
                    const SizedBox.square(dimension: 24),

                    /* Description */
                    Text("Deskripsi",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox.square(dimension: 8),
                    Text(dataDetail.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.justify),
                    const SizedBox.square(dimension: 24),

                    /* Menus */
                    Text("Menu",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ItemMenu(
                            dataDetail: dataDetail,
                            context: context,
                            url: 'assets/food_icon.svg',
                            flagMenu: 'foods'),
                        const SizedBox(width: 16),
                        ItemMenu(
                            dataDetail: dataDetail,
                            context: context,
                            url: 'assets/drink_icon.svg',
                            flagMenu: 'drinks'),
                      ],
                    ),
                    const SizedBox.square(dimension: 24),
                    /* Reviews */
                    Text("Reviews",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxHeight: 100),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: dataDetail.customerReviews.reversed
                              .map((item) =>
                                  ItemReview(context: context, item: item))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
