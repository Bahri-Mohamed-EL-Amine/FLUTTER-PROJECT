import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/core/routes/app_routes.dart';
import 'package:flutter_clean_architecture_posts_app/core/theme.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/blocs/add_delete_update/add_delete_update_post_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/views/posts_view.dart';
import './injection_container.dart' as di;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()..add(PostsGetEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>())
      ],
      child: MaterialApp(
        theme: appTheme,
        home: const PostsView(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
