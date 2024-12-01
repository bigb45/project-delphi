import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff785900),
      surfaceTint: Color(0xff785900),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffca4d),
      onPrimaryContainer: Color(0xff503a00),
      secondary: Color(0xff0e0e0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e2e2e),
      onSecondaryContainer: Color(0xffbdbbba),
      tertiary: Color(0xff964900),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffff8926),
      onTertiaryContainer: Color(0xff341500),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff8f2),
      onSurface: Color(0xff201b11),
      onSurfaceVariant: Color(0xff4f4632),
      outline: Color(0xff827660),
      outlineVariant: Color(0xffd4c5ab),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff363024),
      inversePrimary: Color(0xfffabd00),
      primaryFixed: Color(0xffffdf9e),
      onPrimaryFixed: Color(0xff261a00),
      primaryFixedDim: Color(0xfffabd00),
      onPrimaryFixedVariant: Color(0xff5b4300),
      secondaryFixed: Color(0xffe5e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff474746),
      tertiaryFixed: Color(0xffffdcc6),
      onTertiaryFixed: Color(0xff311300),
      tertiaryFixedDim: Color(0xffffb786),
      onTertiaryFixedVariant: Color(0xff723600),
      surfaceDim: Color(0xffe4d9c8),
      surfaceBright: Color(0xfffff8f2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffef2e1),
      surfaceContainer: Color(0xfff8ecdb),
      surfaceContainerHigh: Color(0xfff2e7d6),
      surfaceContainerHighest: Color(0xffece1d0),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff563f00),
      surfaceTint: Color(0xff785900),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff946f00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0e0e0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e2e2e),
      onSecondaryContainer: Color(0xffebe8e7),
      tertiary: Color(0xff6c3300),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb75b00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f2),
      onSurface: Color(0xff201b11),
      onSurfaceVariant: Color(0xff4b422e),
      outline: Color(0xff695e49),
      outlineVariant: Color(0xff857963),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff363024),
      inversePrimary: Color(0xfffabd00),
      primaryFixed: Color(0xff946f00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff755700),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff757474),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5c5c5c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffb75b00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff924700),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe4d9c8),
      surfaceBright: Color(0xfffff8f2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffef2e1),
      surfaceContainer: Color(0xfff8ecdb),
      surfaceContainerHigh: Color(0xfff2e7d6),
      surfaceContainerHighest: Color(0xffece1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2e2000),
      surfaceTint: Color(0xff785900),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff563f00),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0e0e0e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e2e2e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3b1900),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c3300),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f2),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff2b2312),
      outline: Color(0xff4b422e),
      outlineVariant: Color(0xff4b422e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff363024),
      inversePrimary: Color(0xffffeac3),
      primaryFixed: Color(0xff563f00),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3b2a00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff434343),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2d2d2d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c3300),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4a2100),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe4d9c8),
      surfaceBright: Color(0xfffff8f2),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffef2e1),
      surfaceContainer: Color(0xfff8ecdb),
      surfaceContainerHigh: Color(0xfff2e7d6),
      surfaceContainerHighest: Color(0xffece1d0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffeed1),
      surfaceTint: Color(0xfffabd00),
      onPrimary: Color(0xff3f2e00),
      primaryContainer: Color(0xfff9bc00),
      onPrimaryContainer: Color(0xff463300),
      secondary: Color(0xffc8c6c5),
      onSecondary: Color(0xff303030),
      secondaryContainer: Color(0xff191919),
      onSecondaryContainer: Color(0xffa6a4a4),
      tertiary: Color(0xffffb786),
      onTertiary: Color(0xff502400),
      tertiaryContainer: Color(0xffea7600),
      onTertiaryContainer: Color(0xff030100),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff181309),
      onSurface: Color(0xffece1d0),
      onSurfaceVariant: Color(0xffd4c5ab),
      outline: Color(0xff9c8f78),
      outlineVariant: Color(0xff4f4632),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d0),
      inversePrimary: Color(0xff785900),
      primaryFixed: Color(0xffffdf9e),
      onPrimaryFixed: Color(0xff261a00),
      primaryFixedDim: Color(0xfffabd00),
      onPrimaryFixedVariant: Color(0xff5b4300),
      secondaryFixed: Color(0xffe5e2e1),
      onSecondaryFixed: Color(0xff1b1c1c),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff474746),
      tertiaryFixed: Color(0xffffdcc6),
      onTertiaryFixed: Color(0xff311300),
      tertiaryFixedDim: Color(0xffffb786),
      onTertiaryFixedVariant: Color(0xff723600),
      surfaceDim: Color(0xff181309),
      surfaceBright: Color(0xff3f382d),
      surfaceContainerLowest: Color(0xff120e05),
      surfaceContainerLow: Color(0xff201b11),
      surfaceContainer: Color(0xff241f14),
      surfaceContainerHigh: Color(0xff2f291e),
      surfaceContainerHighest: Color(0xff3a3428),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffeed1),
      surfaceTint: Color(0xfffabd00),
      onPrimary: Color(0xff3f2e00),
      primaryContainer: Color(0xfff9bc00),
      onPrimaryContainer: Color(0xff170f00),
      secondary: Color(0xffcccaca),
      onSecondary: Color(0xff161616),
      secondaryContainer: Color(0xff929090),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffbc90),
      onTertiary: Color(0xff290f00),
      tertiaryContainer: Color(0xffea7600),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff181309),
      onSurface: Color(0xfffffaf7),
      onSurfaceVariant: Color(0xffd8c9af),
      outline: Color(0xffafa189),
      outlineVariant: Color(0xff8e826b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d0),
      inversePrimary: Color(0xff5d4400),
      primaryFixed: Color(0xffffdf9e),
      onPrimaryFixed: Color(0xff191000),
      primaryFixedDim: Color(0xfffabd00),
      onPrimaryFixedVariant: Color(0xff473300),
      secondaryFixed: Color(0xffe5e2e1),
      onSecondaryFixed: Color(0xff111111),
      secondaryFixedDim: Color(0xffc8c6c5),
      onSecondaryFixedVariant: Color(0xff363636),
      tertiaryFixed: Color(0xffffdcc6),
      onTertiaryFixed: Color(0xff210b00),
      tertiaryFixedDim: Color(0xffffb786),
      onTertiaryFixedVariant: Color(0xff592900),
      surfaceDim: Color(0xff181309),
      surfaceBright: Color(0xff3f382d),
      surfaceContainerLowest: Color(0xff120e05),
      surfaceContainerLow: Color(0xff201b11),
      surfaceContainer: Color(0xff241f14),
      surfaceContainerHigh: Color(0xff2f291e),
      surfaceContainerHighest: Color(0xff3a3428),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf7),
      surfaceTint: Color(0xfffabd00),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffc108),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffdfaf9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcccaca),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffaf8),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffbc90),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff181309),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffffaf7),
      outline: Color(0xffd8c9af),
      outlineVariant: Color(0xffd8c9af),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d0),
      inversePrimary: Color(0xff372700),
      primaryFixed: Color(0xffffe4af),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffc108),
      onPrimaryFixedVariant: Color(0xff1f1500),
      secondaryFixed: Color(0xffe9e6e6),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffcccaca),
      onSecondaryFixedVariant: Color(0xff161616),
      tertiaryFixed: Color(0xffffe1d0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffbc90),
      onTertiaryFixedVariant: Color(0xff290f00),
      surfaceDim: Color(0xff181309),
      surfaceBright: Color(0xff3f382d),
      surfaceContainerLowest: Color(0xff120e05),
      surfaceContainerLow: Color(0xff201b11),
      surfaceContainer: Color(0xff241f14),
      surfaceContainerHigh: Color(0xff2f291e),
      surfaceContainerHighest: Color(0xff3a3428),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
