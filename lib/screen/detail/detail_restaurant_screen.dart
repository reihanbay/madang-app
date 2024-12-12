import 'package:flutter/material.dart';
import 'package:madang_app/provider/detail/detail_restaurant_provider.dart';
import 'package:madang_app/provider/favorite_icon_provider.dart';
import 'package:madang_app/provider/payload_provider.dart';
import 'package:madang_app/screen/detail/body_detail_widget.dart';
import 'package:madang_app/screen/widget/form_review_widget.dart';
import 'package:madang_app/static/detail_result_state.dart';
import 'package:provider/provider.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String? id;
  const DetailRestaurantScreen({super.key, this.id});

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  late FavoriteIconProvider notifier;

  String idDetail = "";
  @override
  void initState() {
    super.initState();
    idDetail = widget.id?? context.read<PayloadProvider>().payload?? "";
    notifier = FavoriteIconProvider();

    Future.microtask(() {
      context.read<DetailRestaurantProvider>().fetchDetailRestaurant(idDetail);
    });
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add review',
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const ReviewForm();
            },
          );
          if (!context.mounted || result is! Map<String, String>) return;
              Future.microtask(() {
                if(result.isNotEmpty) {
                  context.read<DetailRestaurantProvider>().postReviews(idDetail, result['name']??"", result["review"]??"");
                  context.read<DetailRestaurantProvider>().fetchDetailRestaurant(idDetail);
                  }
              });
        },
        child: const Icon(Icons.reviews),
      ),
      body:
          Consumer<DetailRestaurantProvider>(builder: (context, value, child) {
        return switch (value.resultDetail) {
          DetailResultLoadingState() =>
            const Center(child: CircularProgressIndicator()),
          DetailResultErrorState(error: var message) =>
            Center(child: Text(message)),
          DetailResultLoadedState(item: var item) =>ChangeNotifierProvider<FavoriteIconProvider>.value(value: notifier, child: BodyDetailWidget(dataDetail: item)),
          _ => const SizedBox()
        };
      }),
    );
  }
}
