import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'auth/user_auth_repository.dart';
import 'ui/screens/add_discipline_screen.dart';
import 'ui/screens/add_task_screen.dart';
import 'ui/screens/discipline_detail_screen.dart';
import 'ui/screens/disciplines_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/register_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/task_detail_screen.dart';
import 'ui/screens/tasks_screen.dart';
import 'ui/screens/welcome_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/welcome',
  routes: <RouteBase>[
    // GoRoute(
    //   path: '/welcome',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const WelcomeScreen();
    //   },
    // ),
    // GoRoute(
    //   path: '/register',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const RegisterScreen();
    //   },
    // ),
    // GoRoute(
    //   path: '/home',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const HomeScreen();
    //   },
    // ),
    // GoRoute(
    //   path: '/disciplines',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const DisciplinesScreen();
    //   },
    //   routes: <RouteBase>[
    //     GoRoute(
    //       path: ':id',
    //       builder: (BuildContext context, GoRouterState state) {
    //         final id = state.pathParameters['id']!;
    //         return DisciplineDetailScreen(disciplineId: id);
    //       },
    //     ),
    //   ],
    // ),
    GoRoute(
      path: '/add_discipline',
      builder: (BuildContext context, GoRouterState state) {
        return const AddDisciplineScreen();
      },
    ),
    GoRoute(
      path: '/tasks',
      builder: (BuildContext context, GoRouterState state) {
        return const TasksScreen();
      },
      // routes: <RouteBase>[
      //   GoRoute(
      //     path: ':id',
      //     builder: (BuildContext context, GoRouterState state) {
      //       final id = state.pathParameters['id']!;
      //       return TaskDetailScreen(taskId: id);
      //     },
      //   ),
      // ],
    ),
    // GoRoute(
    //   path: '/add_task',
    //   builder: (BuildContext context, GoRouterState state) {
    //     final disciplineId = state.uri.queryParameters['disciplineId'];
    //     return AddTaskScreen(disciplineId: disciplineId);
    //   },
    // ),
    // GoRoute(
    //   path: '/settings',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const SettingsScreen();
    //   },
    // ),
  ],

  // redirect: (BuildContext context, GoRouterState state) {
  //   final authRepository = context.read<UserAuthRepository>();
  //   final isLoggedIn = authRepository.currentUsername != null;
  //
  //   final loggingIn = state.matchedLocation == '/welcome' || state.matchedLocation == '/register';
  //
  //   if (!isLoggedIn && !loggingIn) {
  //     return '/welcome';
  //   }
  //
  //   if (isLoggedIn && loggingIn) {
  //     return '/home';
  //   }
  //
  //   return null;
  // },
);