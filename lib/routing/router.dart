import 'package:dough_dock/core/repositories/pizza_repository.dart';
import 'package:dough_dock/core/repositories/session_repository.dart';
import 'package:dough_dock/core/services/dough_calculator.dart';
import 'package:dough_dock/core/services/dough_planner.dart';
import 'package:dough_dock/ui/core/main_page.dart';
import 'package:dough_dock/ui/dough/dough_page.dart';
import 'package:dough_dock/ui/dough/view_model/dough_view_model.dart';
import 'package:dough_dock/ui/profile/profile_page.dart';
import 'package:dough_dock/ui/sessions/detail/session_detail_page.dart';
import 'package:dough_dock/ui/sessions/detail/view_model/session_detail_view_model.dart';
import 'package:dough_dock/ui/sessions/sessions_page.dart';
import 'package:dough_dock/ui/sessions/view_model/sessions_view_model.dart';
import 'package:dough_dock/ui/toppings/toppings_page.dart';
import 'package:dough_dock/ui/core/under_construction.dart';
import 'package:dough_dock/routing/routes.dart';
import 'package:dough_dock/ui/toppings/view_model/toppings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter get router => _router;
  static final _globalNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: _globalNavigatorKey,
    initialLocation: Routes.home.index,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.home.index,
        redirect: (context, state) => Routes.home.dough,
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _globalNavigatorKey,
        builder: (context, state, navigationShell) {
          return MainPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.home.dough,
                builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => DoughViewModel(
                    sessionRepository: context.read<SessionRepository>(),
                    calculator: context.read<DoughCalculator>(),
                    planner: context.read<DoughPlanner>(),
                  ),
                  child: const DoughPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.home.sessions,
                builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => SessionsViewModel(
                    sessionRepository: context.read<SessionRepository>(),
                  ),
                  child: const SessionsPage(),
                ),
                routes: [
                  GoRoute(
                    path: Routes.home.sessionDetailPath,
                    builder: (context, state) {
                      final id = int.parse(state.pathParameters['id']!);
                      final session = context.read<SessionRepository>().getById(id)!;
                      return ChangeNotifierProvider(
                        create: (context) => SessionDetailViewModel(
                          session: session,
                          calculator: context.read<DoughCalculator>(),
                        ),
                        child: const SessionDetailPage(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.home.toppings,
                builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => ToppingsViewModel(
                    pizzaRepository: context.read<PizzaRepository>(),
                  ),
                  child: const ToppingsPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.home.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder:
        (context, state) => Center(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '404',
                    style: TextStyle(
                      fontSize: 72,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Text('PAGE NOT FOUND', style: TextStyle(fontSize: 28)),
                ],
              ),
            ),
          ),
        ),
  );

  static Scaffold underConstructionPage() {
    return Scaffold(appBar: AppBar(), body: UnderConstruction());
  }
}
