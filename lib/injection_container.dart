import 'package:flutter_clean_architecture_posts_app/core/network/network_info.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/datasources/local/local_data_source.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/datasources/remote/remote_data_source.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/blocs/add_delete_update/add_delete_update_post_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/domain/usecases/add_post_usecase.dart';
import 'features/posts/domain/usecases/delete_post_usecase.dart';
import 'features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'features/posts/domain/usecases/update_post_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! features

  //? posts

  // bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUsecase: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPostUsecase: sl(), deletePostUsecase: sl(), updatePostUsecase: sl()));

  // usecases
  sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
  sl.registerLazySingleton(() => AddPostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));
  // repositories
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      localDataSource: sl(), networkInfoImpl: sl(), remoteDataSource: sl()));
  // datasources
  sl.registerLazySingleton(() => LocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton(() => RemoteDataSourceImpl(client: sl()));

  //! core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));
  //! externals
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
