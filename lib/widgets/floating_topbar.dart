import 'package:flutter/material.dart';

class FloatingTopbar extends StatefulWidget implements PreferredSizeWidget {
  const FloatingTopbar({super.key});

  @override
  State<FloatingTopbar> createState() => _FloatingTopbarState();

  @override
  Size get preferredSize => const Size.fromHeight(53 + 64);
}

class _FloatingTopbarState extends State<FloatingTopbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surfaceContainer),
                child: Icon(
                  Icons.filter_list_rounded,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                "Choose a starting Point",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationTopbar extends StatelessWidget implements PreferredSizeWidget {
  const NavigationTopbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(53 + 64);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 53,
              width: 53,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      color: Theme.of(context)
                          .colorScheme
                          .inverseSurface
                          .withOpacity(0.1),
                      blurRadius: 16,
                      spreadRadius: 0)
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context)
                        .colorScheme
                        .inverseSurface
                        .withOpacity(0.1),
                    blurRadius: 16,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text("Where are you?",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
