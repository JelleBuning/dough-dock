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
  var pageIndex = 0;
  var toolbarHeight = 75.0;
  var destinations = [
    Destination(
      icon: Icon(Icons.calendar_month_outlined),
      selectedIcon: Icon(Icons.calendar_month_rounded),
      label: "Dough",
      route: Routes.home.dough,
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
  void initState() {
    pageIndex = widget.navigationShell.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Row(
        children: [
          if (!isMobile)
            Padding(
              padding: EdgeInsets.only(top: toolbarHeight),
              child: NavigationRail(
                labelType: NavigationRailLabelType.all,
                onDestinationSelected:
                    (int index) => {
                      pageIndex = index,
                      context.go(destinations[pageIndex].route),
                    },
                groupAlignment: -0.25,
                leading: SizedBox(
                  height: 56,
                  width: 56,
                  child:
                      !isMobile
                          ? _buildFab(
                            destinations[pageIndex].fabIcon,
                            destinations[pageIndex].fabPressed,
                          )
                          : null,
                ),
                destinations:
                    destinations.map((destination) {
                      return NavigationRailDestination(
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        label: Text(destination.label),
                      );
                    }).toList(),
                selectedIndex: pageIndex,
              ),
            ),
          Expanded(
            child: Scaffold(
              body: widget.navigationShell, // Use the navigation shell here
              floatingActionButton:
                  isMobile
                      ? _buildFab(
                        destinations[pageIndex].fabIcon,
                        destinations[pageIndex].fabPressed,
                      )
                      : null,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.noAnimation,
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          isMobile
              ? NavigationBar(
                destinations:
                    destinations.map((destination) {
                      return NavigationDestination(
                        icon: destination.icon,
                        selectedIcon: destination.selectedIcon,
                        label: destination.label,
                      );
                    }).toList(),
                selectedIndex: pageIndex,
                onDestinationSelected:
                    (int index) => {
                      pageIndex = index,
                      context.go(destinations[pageIndex].route),
                    },
              )
              : null,
    );
  }

  Widget _buildFab(Icon? icon, void Function()? onPressed) {
    return AnimatedOpacity(
      opacity: onPressed != null ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: FloatingActionButton(onPressed: onPressed, child: icon),
    );
  }
}
