import 'package:flutter/material.dart';
import 'package:madang_app/screen/home/card_view_widget.dart';

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
  Widget build(BuildContext context) {
    final _nodes = FocusNode();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
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
            const SizedBox(height: 24),
            const CardView(),
            const CardView(),
            const CardView(),
            
          ],
        ),
      ),
    );
  }
}

