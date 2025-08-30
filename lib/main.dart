import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './app/providers/theme_provider.dart';
import './app/theme/app_theme.dart';
import './features/home/providers/deal_provider.dart';
import './features/home/repositories/deal_repository.dart';
import './features/navigation/main_navigation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => DealProvider(DealRepository()),
        ),
      ],
      child: const DealDiverApp(),
    ),
  );
}

class DealDiverApp extends StatelessWidget {
  const DealDiverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Deal Diver',
          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const MainNavigation(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
