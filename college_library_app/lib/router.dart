import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'models/auth_model.dart';
import 'screens/catalog_screen.dart';
import 'screens/book_screen.dart';
import 'screens/reserve_screen.dart';
import 'screens/login_screen.dart';
import 'screens/my_books_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/date_picker_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final catalogNavigatorKey = GlobalKey<NavigatorState>();
final booksNavigatorKey = GlobalKey<NavigatorState>();
final profileNavigatorKey = GlobalKey<NavigatorState>();

class RouterRefresh extends ChangeNotifier {
  RouterRefresh(AuthModel auth) {
    auth.addListener(notifyListeners);
  }
}

GoRouter createRouter(AuthModel auth) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/catalog',
    refreshListenable: RouterRefresh(auth),
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Сторінку не знайдено')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 12),
            Text('Невідома адреса: ${state.uri.path}'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.go('/catalog'),
              child: const Text('До каталогу'),
            ),
          ],
        ),
      ),
    ),
    redirect: (context, state) {
      final path = state.uri.path;
      final isLogin = path == '/login';
      final isProtected = path.endsWith('/reserve');

      if (isProtected && !auth.isLoggedIn) {
        return '/login?from=${Uri.encodeComponent(state.uri.toString())}';
      }

      if (isLogin && auth.isLoggedIn) {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.startsWith('/') && !from.startsWith('//')) {
          return from;
        }
        return '/catalog';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => LoginScreen(
          from: state.uri.queryParameters['from'],
        ),
      ),
      GoRoute(
        path: '/choose-date',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const DatePickerScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) =>
                  navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.menu_book),
                  label: 'Каталог',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bookmark),
                  label: 'Мої книги',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Профіль',
                ),
              ],
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: catalogNavigatorKey,
            routes: [
              GoRoute(
                path: '/catalog',
                builder: (context, state) => const CatalogScreen(),
                routes: [
                  GoRoute(
                    path: 'book/:bookId',
                    builder: (context, state) => BookScreen(
                      bookId: state.pathParameters['bookId']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'reserve',
                        parentNavigatorKey: rootNavigatorKey,
                        builder: (context, state) => ReserveScreen(
                          bookId: state.pathParameters['bookId']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: booksNavigatorKey,
            routes: [
              GoRoute(
                path: '/my-books',
                builder: (context, state) => const MyBooksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}