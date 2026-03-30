import 'package:dough_dock/ui/core/models/destination.dart';
import 'package:dough_dock/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const _toolbarHeight = 75.0;
  final _destinations = [
    Destination(
      icon: Icon(Icons.calendar_month_outlined),
      selectedIcon: Icon(Icons.calendar_month_rounded),
      label: "Dough",
      route: Routes.home.dough,
    ),
    Destination(
      icon: Icon(Icons.history_outlined),
      selectedIcon: Icon(Icons.history_rounded),
      label: "Sessions",
      route: Routes.home.sessions,
    ),
    Destination(
      icon: Icon(Icons.local_pizza_outlined),
      selectedIcon: Icon(Icons.local_pizza_rounded),
      label: "Toppings",
      route: Routes.home.toppings,
    ),
    Destination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: "Profile",
      route: Routes.home.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pageIndex = widget.navigationShell.currentIndex;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Row(
        children: [
          if (!isMobile)
            Padding(
              padding: const EdgeInsets.only(top: _toolbarHeight),
              child: NavigationRail(
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (int index) => context.go(_destinations[index].route),
                groupAlignment: -0.25,
                destinations:
                    _destinations.map((destination) {
                      return NavigationRailDestination(
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        label: Text(destination.label),
                      );
                    }).toList(),
                selectedIndex: pageIndex,
              ),
            ),
          Expanded(child: Scaffold(body: widget.navigationShell)),
        ],
      ),
      bottomNavigationBar:
          isMobile
              ? NavigationBar(
                destinations:
                    _destinations.map((destination) {
                      return NavigationDestination(
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        label: destination.label,
                      );
                    }).toList(),
                selectedIndex: pageIndex,
                onDestinationSelected: (int index) => context.go(_destinations[index].route),
              )
              : null,
    );
  }
}
