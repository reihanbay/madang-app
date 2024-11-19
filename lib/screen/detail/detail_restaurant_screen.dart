import 'package:flutter/material.dart';
import 'package:madang_app/provider/detail_restaurant_provider.dart';
import 'package:madang_app/screen/detail/body_detail_widget.dart';
import 'package:madang_app/screen/detail/form_review_widget.dart';
import 'package:madang_app/static/detail_result_state.dart';
import 'package:provider/provider.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String id;
  const DetailRestaurantScreen({super.key, required this.id});

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailRestaurantProvider>().fetchDetailRestaurant(widget.id);
    });
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
                  context.read<DetailRestaurantProvider>().postReviews(widget.id, result['name']??"", result["review"]??"");
                  context.read<DetailRestaurantProvider>().fetchDetailRestaurant(widget.id);
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
          DetailResultLoadedState(item: var item) =>
            BodyDetailWidget(dataDetail: item),
          _ => const SizedBox()
        };
      }),
    );
  }
}
