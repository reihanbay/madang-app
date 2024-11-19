import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff8f4a4f),
      surfaceTint: Color(0xff8f4a4f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdadb),
      onPrimaryContainer: Color(0xff3b0810),
      secondary: Color(0xff765658),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdadb),
      onSecondaryContainer: Color(0xff2c1516),
      tertiary: Color(0xff76592f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffddb3),
      onTertiaryContainer: Color(0xff291800),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffff8f7),
      onBackground: Color(0xff22191a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191a),
      surfaceVariant: Color(0xfff4dddd),
      onSurfaceVariant: Color(0xff524343),
      outline: Color(0xff857373),
      outlineVariant: Color(0xffd7c1c2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2e),
      inverseOnSurface: Color(0xffffedec),
      inversePrimary: Color(0xffffb2b6),
      primaryFixed: Color(0xffffdadb),
      onPrimaryFixed: Color(0xff3b0810),
      primaryFixedDim: Color(0xffffb2b6),
      onPrimaryFixedVariant: Color(0xff723339),
      secondaryFixed: Color(0xffffdadb),
      onSecondaryFixed: Color(0xff2c1516),
      secondaryFixedDim: Color(0xffe6bdbe),
      onSecondaryFixedVariant: Color(0xff5c3f40),
      tertiaryFixed: Color(0xffffddb3),
      onTertiaryFixed: Color(0xff291800),
      tertiaryFixedDim: Color(0xffe7c08e),
      onTertiaryFixedVariant: Color(0xff5c421a),
      surfaceDim: Color(0xffe7d6d6),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffceaea),
      surfaceContainerHigh: Color(0xfff6e4e4),
      surfaceContainerHighest: Color(0xfff0dede),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff6e2f35),
      surfaceTint: Color(0xff8f4a4f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa95f64),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff583b3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8e6c6d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff583e17),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8f6f43),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f7),
      onBackground: Color(0xff22191a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff22191a),
      surfaceVariant: Color(0xfff4dddd),
      onSurfaceVariant: Color(0xff4e3f40),
      outline: Color(0xff6c5b5b),
      outlineVariant: Color(0xff887677),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2e),
      inverseOnSurface: Color(0xffffedec),
      inversePrimary: Color(0xffffb2b6),
      primaryFixed: Color(0xffa95f64),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff8c474d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8e6c6d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff745455),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8f6f43),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff74572d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d6d6),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffceaea),
      surfaceContainerHigh: Color(0xfff6e4e4),
      surfaceContainerHighest: Color(0xfff0dede),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff440f16),
      surfaceTint: Color(0xff8f4a4f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6e2f35),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff341b1d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff583b3d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff321e00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff583e17),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f7),
      onBackground: Color(0xff22191a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xfff4dddd),
      onSurfaceVariant: Color(0xff2d2121),
      outline: Color(0xff4e3f40),
      outlineVariant: Color(0xff4e3f40),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff382e2e),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffffe6e7),
      primaryFixed: Color(0xff6e2f35),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff521920),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff583b3d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff402627),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff583e17),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3f2803),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe7d6d6),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f0),
      surfaceContainer: Color(0xfffceaea),
      surfaceContainerHigh: Color(0xfff6e4e4),
      surfaceContainerHighest: Color(0xfff0dede),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb2b6),
      surfaceTint: Color(0xffffb2b6),
      onPrimary: Color(0xff561d23),
      primaryContainer: Color(0xff723339),
      onPrimaryContainer: Color(0xffffdadb),
      secondary: Color(0xffe6bdbe),
      onSecondary: Color(0xff44292b),
      secondaryContainer: Color(0xff5c3f40),
      onSecondaryContainer: Color(0xffffdadb),
      tertiary: Color(0xffe7c08e),
      onTertiary: Color(0xff432c06),
      tertiaryContainer: Color(0xff5c421a),
      onTertiaryContainer: Color(0xffffddb3),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff1a1112),
      onBackground: Color(0xfff0dede),
      surface: Color(0xff1a1112),
      onSurface: Color(0xfff0dede),
      surfaceVariant: Color(0xff524343),
      onSurfaceVariant: Color(0xffd7c1c2),
      outline: Color(0xff9f8c8c),
      outlineVariant: Color(0xff524343),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dede),
      inverseOnSurface: Color(0xff382e2e),
      inversePrimary: Color(0xff8f4a4f),
      primaryFixed: Color(0xffffdadb),
      onPrimaryFixed: Color(0xff3b0810),
      primaryFixedDim: Color(0xffffb2b6),
      onPrimaryFixedVariant: Color(0xff723339),
      secondaryFixed: Color(0xffffdadb),
      onSecondaryFixed: Color(0xff2c1516),
      secondaryFixedDim: Color(0xffe6bdbe),
      onSecondaryFixedVariant: Color(0xff5c3f40),
      tertiaryFixed: Color(0xffffddb3),
      onTertiaryFixed: Color(0xff291800),
      tertiaryFixedDim: Color(0xffe7c08e),
      onTertiaryFixedVariant: Color(0xff5c421a),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff413737),
      surfaceContainerLowest: Color(0xff140c0c),
      surfaceContainerLow: Color(0xff22191a),
      surfaceContainer: Color(0xff271d1e),
      surfaceContainerHigh: Color(0xff322828),
      surfaceContainerHighest: Color(0xff3d3232),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb9bc),
      surfaceTint: Color(0xffffb2b6),
      onPrimary: Color(0xff34030b),
      primaryContainer: Color(0xffca7a7f),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeac1c2),
      onSecondary: Color(0xff261011),
      secondaryContainer: Color(0xffac8889),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffebc491),
      onTertiary: Color(0xff221300),
      tertiaryContainer: Color(0xffad8b5d),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff1a1112),
      onBackground: Color(0xfff0dede),
      surface: Color(0xff1a1112),
      onSurface: Color(0xfffff9f9),
      surfaceVariant: Color(0xff524343),
      onSurfaceVariant: Color(0xffdbc6c6),
      outline: Color(0xffb29e9e),
      outlineVariant: Color(0xff917f7f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dede),
      inverseOnSurface: Color(0xff322828),
      inversePrimary: Color(0xff74343a),
      primaryFixed: Color(0xffffdadb),
      onPrimaryFixed: Color(0xff2c0007),
      primaryFixedDim: Color(0xffffb2b6),
      onPrimaryFixedVariant: Color(0xff5e2329),
      secondaryFixed: Color(0xffffdadb),
      onSecondaryFixed: Color(0xff200b0c),
      secondaryFixedDim: Color(0xffe6bdbe),
      onSecondaryFixedVariant: Color(0xff4a2f30),
      tertiaryFixed: Color(0xffffddb3),
      onTertiaryFixed: Color(0xff1b0e00),
      tertiaryFixedDim: Color(0xffe7c08e),
      onTertiaryFixedVariant: Color(0xff4a310b),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff413737),
      surfaceContainerLowest: Color(0xff140c0c),
      surfaceContainerLow: Color(0xff22191a),
      surfaceContainer: Color(0xff271d1e),
      surfaceContainerHigh: Color(0xff322828),
      surfaceContainerHighest: Color(0xff3d3232),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff9f9),
      surfaceTint: Color(0xffffb2b6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffb9bc),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffeac1c2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffaf7),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffebc491),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff1a1112),
      onBackground: Color(0xfff0dede),
      surface: Color(0xff1a1112),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff524343),
      onSurfaceVariant: Color(0xfffff9f9),
      outline: Color(0xffdbc6c6),
      outlineVariant: Color(0xffdbc6c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff0dede),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff4e171d),
      primaryFixed: Color(0xffffdfe0),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb9bc),
      onPrimaryFixedVariant: Color(0xff34030b),
      secondaryFixed: Color(0xffffdfe0),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffeac1c2),
      onSecondaryFixedVariant: Color(0xff261011),
      tertiaryFixed: Color(0xffffe2c0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffebc491),
      onTertiaryFixedVariant: Color(0xff221300),
      surfaceDim: Color(0xff1a1112),
      surfaceBright: Color(0xff413737),
      surfaceContainerLowest: Color(0xff140c0c),
      surfaceContainerLow: Color(0xff22191a),
      surfaceContainer: Color(0xff271d1e),
      surfaceContainerHigh: Color(0xff322828),
      surfaceContainerHighest: Color(0xff3d3232),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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
