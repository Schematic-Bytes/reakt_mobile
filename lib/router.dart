import 'package:go_router/go_router.dart';
import 'package:reakt/routes/authetication_route.dart';
import 'package:reakt/routes/home_route.dart';
import 'package:reakt/routes/intro_route.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const AuthRoute(),
      redirect: AuthRoute.redirect,
    ),
    GoRoute(
      path: "/intro",
      builder: (context, state) => const IntroRoute(),
    ),
    GoRoute(
      path: "/dashboard",
      builder: (context, state) => const HomeRoute(),
    )
  ],
);
