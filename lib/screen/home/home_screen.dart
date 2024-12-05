import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madang_app/provider/home/list_restaurant_provider.dart';
import 'package:madang_app/screen/widget/restaurant_list_widget.dart';
import 'package:madang_app/static/list_result_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();

  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<ListRestaurantProvider>().fetchRestaurants();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nodes = FocusNode();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                alignment: Alignment.topLeft,
                child: Text("Madang",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontSize: 32)),
              ),
              const SizedBox(height: 24),
              SearchField(nodes: nodes),
              const SizedBox(height: 16),
              Consumer<ListRestaurantProvider>(
                  builder: (context, value, child) {
                return switch (value.resultList) {
                  ListResultLoadingState() => const Expanded(
                      child: Center(child: CircularProgressIndicator())),
                  ListResultErrorState(error: var message) =>
                    Expanded(child: Center(child: Text(message))),
                  ListResultLoadedState(data: var data) => Flexible(
                        child: LayoutBuilder(builder: (context, constraint) {
                      if (constraint.maxWidth <= 600) {
                        return RestaurantList(data: data);
                      } else if (constraint.maxWidth <= 1200) {
                        return RestaurantGrid(data: data, gridCount: 3);
                      } else {
                        return RestaurantGrid(data: data, gridCount: 5);
                      }
                    })),
                  _ => const SizedBox()
                };
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.nodes,
  });

  final FocusNode nodes;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.search,
      enableInteractiveSelection: false,
      focusNode: nodes,
      onTapOutside: (event) {
        nodes.unfocus();
      },
      onFieldSubmitted: (value) {
        Timer(const Duration(milliseconds: 200), () {
          Future.microtask(() {
            context
                .read<ListRestaurantProvider>()
                .fetchRestaurants(query: value);
          });
        });
      },
      onChanged: (value) {
        if (value.isEmpty) {
          Future.microtask(() {
            context.read<ListRestaurantProvider>().fetchRestaurants();
          });
        }
      },
      decoration: InputDecoration(
          hintText: "Find Restaurant",
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.onPrimaryContainer)),
          prefixIcon: const Icon(Icons.search)),
    );
  }
}