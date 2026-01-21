import 'package:flutter/material.dart';

/// App color palette - water/nature themed for conservation
class AppColors {
  // Primary palette (water blue)
  static const primary = Color(0xFF1976D2);
  static const primaryLight = Color(0xFF63A4FF);
  static const primaryDark = Color(0xFF004BA0);

  // Secondary palette (nature green)
  static const secondary = Color(0xFF388E3C);
  static const secondaryLight = Color(0xFF6ABF69);
  static const secondaryDark = Color(0xFF00600F);

  // Semantic colors
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFC107);
  static const error = Color(0xFFF44336);
  static const info = Color(0xFF2196F3);

  // Neutral palette
  static const background = Color(0xFFF5F7FA);
  static const surface = Colors.white;
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const divider = Color(0xFFBDBDBD);

  // Dark theme
  static const backgroundDark = Color(0xFF121212);
  static const surfaceDark = Color(0xFF1E1E1E);
  static const textPrimaryDark = Color(0xFFE0E0E0);
}

/// Typography scale
class AppTypography {
  static const fontFamily = 'Roboto';

  static const headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

/// Spacing constants (8pt grid)
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Border radius constants
class AppRadius {
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 16;
  static const double full = 999;
}
