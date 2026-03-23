import 'package:dough_dock/core/enumerations/yeast_type.dart';
import 'package:dough_dock/ui/core/main_page.dart';
import 'package:dough_dock/ui/dough/dough_page.dart';
import 'package:dough_dock/ui/dough/view_model/dough_view_model.dart';
import 'package:dough_dock/ui/profile/profile_page.dart';
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
      // Index redirect
      GoRoute(
        path: Routes.home.index,
        redirect: (context, state) {
          return Routes.home.dough; // homepage
        },
      ),
      // Routes
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
                builder:
                    (context, state) => DoughPage(
                      viewModel: DoughViewModel(
                        amount: 4,
                        weightPerPortionG: 250,
                        waterPercentage: 60,
                        saltPercentage: 2.5,
                        yeastType: YeastType.fresh,
                        rtLeaveningHours: 6,
                        rtTemperatureCelsius: 20,
                        sessionRepository: context.read(),
                      ),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.home.toppings,
                builder:
                    (context, state) => ToppingsPage(
                      viewModel: ToppingsViewModel(
                        pizzaRepository: context.read(),
                      ),
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
