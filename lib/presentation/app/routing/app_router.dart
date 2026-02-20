import 'package:go_router/go_router.dart';

import '../../games/balance_it/balance_it_page.dart';
import '../../games/hold_it/hold_it_page.dart';
import '../../games/stop_it/stop_it_page.dart';
import '../../games/tapme/tapme_page.dart';
import '../home/home_page.dart';
import '../loading/loading_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/tapme',
        builder: (context, state) => const TapMePage(),
      ),
      GoRoute(
        path: '/stop-it',
        builder: (context, state) => const StopItPage(),
      ),
      GoRoute(
        path: '/hold-it',
        builder: (context, state) => const HoldItPage(),
      ),
      GoRoute(
        path: '/balance-it',
        builder: (context, state) => const BalanceItPage(),
      ),
    ],
  );
}
