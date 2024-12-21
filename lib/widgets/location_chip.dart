import 'package:flutter/material.dart';

class LocationChip extends StatelessWidget {
  final bool isFavorite;
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  const LocationChip(
      {super.key,
      this.isFavorite = false,
      required this.text,
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        child: Container(
            height: 53,
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.inversePrimary
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
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
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
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
      ),
    );
  }
}
