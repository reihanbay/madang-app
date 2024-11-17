import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardView extends StatelessWidget {
  const CardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 364, maxHeight: 104),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
          borderRadius: BorderRadius.circular(16)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {

          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 80,
                      minHeight: 80
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(16)),
                    child: SvgPicture.asset('assets/bowl.svg'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rumah Makan Padang",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500)),
                        Text("Medan",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24),
                            const SizedBox(width: 2),
                            Text("4.8",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
