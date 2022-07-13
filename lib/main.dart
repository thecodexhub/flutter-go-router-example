import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_go_router_example/repository/repository.dart';
import 'package:flutter_go_router_example/screens/screens.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ColorRepository>(
      create: (_) => ColorRepository()..loadColorMap(),
      child: MaterialApp.router(
        title: 'Flutter Go Router Example',
        theme: ThemeData(brightness: Brightness.dark),
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LandingScreen()),
      GoRoute(
        path: '/colors',
        builder: (context, state) => const ColorExploreScreen(),
      ),
      GoRoute(
        path: '/colors/:id',
        builder: (context, state) {
          return ColorShadeScreen(
            key: state.pageKey,
            index: int.parse(state.params['id'] ?? '0'),
            alpha: int.parse(state.queryParams['alpha'] ?? '255'),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  );
}
