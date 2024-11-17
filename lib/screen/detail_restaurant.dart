import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailRestaurantScreen extends StatelessWidget {
  const DetailRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                  minWidth: 360, maxWidth: double.infinity, minHeight: 412),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(24)),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1689479799288-1d27a6a72c47?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"))),
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
                            Text("Rumah Makan Padang",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w500)),
                            Text("Medan",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.bookmark))
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
                          child: Text("4.8",
                              style: Theme.of(context).textTheme.bodyMedium)),
                      const SizedBox(width: 2),
                      Expanded(
                          child: Text("(2 Reviews)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w300))),
                    ],
                  ),
                  const SizedBox.square(dimension: 24),
                  Text("Deskripsi",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox.square(dimension: 8),
                  Text(
                      "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
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
                      ItemMenu(context, 'assets/food_icon.svg', "Makanan"),
                      const SizedBox(width: 16),
                      ItemMenu(context, 'assets/drink_icon.svg', "Minuman"),
                      ],
                  ),

                  const SizedBox.square(dimension: 24),
                  Text("Reviews",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column ItemMenu(BuildContext context, String url, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryContainer),
            child:
                SvgPicture.asset(url, width: 24, height: 24),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
