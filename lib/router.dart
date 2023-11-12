import 'package:go_router/go_router.dart';
import 'package:reakt/routes/intro.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const Intro(),
    ),
  ],
);
