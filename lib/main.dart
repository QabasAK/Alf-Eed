import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'data/terms_repository.dart';
import 'screens/home_screen.dart';
import 'screens/lexicon_screen.dart';
import 'screens/term_detail_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    // Provide the repository at the root so every screen can read it via
    // context.read<TermsRepository>().  Swap LocalTermsRepository for any
    // other implementation here — screens stay untouched.
    Provider<TermsRepository>(
      create: (_) => const LocalTermsRepository(),
      child: const JslLexiconApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) => const HomeScreen(),
    ),
    GoRoute(
      path: '/lexicon',
      builder: (context, _) => const LexiconScreen(),
    ),
    GoRoute(
      path: '/term/:id',
      builder: (_, state) => TermDetailScreen(
        termId: state.pathParameters['id']!,
      ),
    ),
  ],
);

class JslLexiconApp extends StatelessWidget {
  const JslLexiconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LIU — JSL Engineering Lexicon',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router,
    );
  }
}
