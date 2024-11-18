import 'package:flutter/material.dart';
import 'package:madang_app/provider/list_restaurant_provider.dart';
import 'package:madang_app/screen/home/card_view_widget.dart';
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
      context.read<ListRestaurantProvider>().fetchRestaurants();
    });
  }
  @override
  Widget build(BuildContext context) {
    final _nodes = FocusNode();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              alignment: Alignment.topLeft,
              child: Text("Madang", style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontSize: 32
              )),
            ),
            const SizedBox(height: 24),
            TextFormField(
              enableInteractiveSelection: false,
              focusNode: _nodes,
              onTapOutside: (event) {
                _nodes.unfocus();
              },
              onChanged: (value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
              },
              decoration: InputDecoration(
                hintText: "Find Restaurant",
                hintStyle:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    width: 2, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                prefixIcon: const Icon(Icons.search)
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ListRestaurantProvider>(builder: (context, value, child) {
              return switch (value.resultList) {
                ListResultLoadingState() => const Center(child: CircularProgressIndicator()),
                ListResultErrorState(error: var message) => Center(child: Text(message)),
                ListResultLoadedState(data: var data) => 
                Flexible(child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return CardView(item: item);
                  }
                )),
                _ => const SizedBox()
              };
            }),
          ],
        ),
      ),
    );
  }
}

