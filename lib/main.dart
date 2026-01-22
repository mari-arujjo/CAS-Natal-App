import 'package:flutter/material.dart';
import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/rotas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppWidget(),
    ),
  );
}

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cores = Cores();
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'CAS Natal + IFRN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
      
        // --- ESTILIZAÇÃO DO NAVIGATION RAIL (Desktop/Web) ---
        navigationRailTheme: NavigationRailThemeData(
          selectedLabelTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          unselectedLabelTextStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: cores.preto,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: cores.preto,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: cores.preto),
          bodyMedium: TextStyle(color: cores.preto),
          bodySmall: TextStyle(color: cores.preto),
        ),
      ),
      routerConfig: router,
    );
  }
}