import 'package:flutter/material.dart';

class LocationChip extends StatelessWidget {
  final bool isFavorite;
  final String text;
  const LocationChip({super.key, this.isFavorite = false, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      child: Container(
          height: 53,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context)
                      .colorScheme
                      .inverseSurface
                      .withOpacity(0.1),
                  blurRadius: 16,
                  spreadRadius: 8)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isFavorite
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.star,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            size: 8),
                      )
                    : const SizedBox(),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          )),
    );
  }
}
