import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_delphi/widgets/animated_shadow_container.dart';

class FloatingSeparableTopbar extends StatefulWidget
    implements PreferredSizeWidget {
  final bool isSeparated;
  final Widget child;
  final Widget leadingIcon;
  final VoidCallback? onTopbarClicked;
  final VoidCallback? onSeparatedIconClicked;

  const FloatingSeparableTopbar({
    super.key,
    this.isSeparated = false,
    required this.child,
    required this.leadingIcon,
    this.onTopbarClicked,
    this.onSeparatedIconClicked,
  });

  @override
  State<FloatingSeparableTopbar> createState() =>
      _FloatingSeparableTopbarState();

  @override
  Size get preferredSize => const Size.fromHeight(53 + 64);
}

class _FloatingSeparableTopbarState extends State<FloatingSeparableTopbar> {
  BorderRadius leftCardBorderRadius = BorderRadius.circular(0);
  BorderRadius rightCardBorderRadius = BorderRadius.circular(0);
  double gap = 0.0;
  static const radius = 16.0;

  static const duration = Duration(milliseconds: 150);
  @override
  Widget build(BuildContext context) {
    bool isSeparated = widget.isSeparated;
    leftCardBorderRadius = isSeparated
        ? BorderRadius.circular(radius)
        : const BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          );
    rightCardBorderRadius = isSeparated
        ? BorderRadius.circular(radius)
        : const BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius),
          );
    gap = isSeparated ? 16 : 0;

    return GestureDetector(
      onTap: () => {
        widget.onTopbarClicked?.call(),
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedShadowContainer(
                isShadowVisible: !isSeparated,
                animateShadow: false,
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: GestureDetector(
                  onTap: () => {
                    widget.onSeparatedIconClicked?.call(),
                  },
                  child: AnimatedContainer(
                    duration: duration,
                    height: 53,
                    width: 53,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: rightCardBorderRadius,
                    ),
                    child: AnimatedSwitcher(
                      duration: duration,
                      child: widget.leadingIcon,
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: duration,
                width: gap,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => {
                    widget.onTopbarClicked?.call(),
                  },
                  child: AnimatedShadowContainer(
                    isShadowVisible: isSeparated,
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    // width animation
                    child: AnimatedContainer(
                      height: 53,
                      duration: duration,
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        borderRadius: leftCardBorderRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        // fade animation
                        child: AnimatedSwitcher(
                          duration: duration,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
