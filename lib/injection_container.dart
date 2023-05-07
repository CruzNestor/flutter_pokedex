import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'src/core/platform/network_info.dart';
import 'src/features/home/data/datasources/home_remote_datasource.dart';
import 'src/features/home/data/repositories/home_repository_impl.dart';
import 'src/features/home/domain/repositories/home_repository.dart';
import 'src/features/home/domain/usecases/get_pokemon_page.dart';
import 'src/features/home/presentation/cubit/home_cubit.dart';
import 'src/features/pokemon_detail/data/datasources/pokemon_detail_remote_datasource.dart';
import 'src/features/pokemon_detail/data/repositories/pokemon_detail_repository_impl.dart';
import 'src/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import 'src/features/pokemon_detail/domain/usecases/get_pokemon_detail.dart';
import 'src/features/pokemon_detail/presentation/cubit/pokemon_detail_cubit.dart';
import 'src/features/search_pokemon/data/datasources/search_pokemon_remote_datasource.dart';
import 'src/features/search_pokemon/data/repositories/search_pokemon_repository_impl.dart';
import 'src/features/search_pokemon/domain/repositories/search_pokemon_repository.dart';
import 'src/features/search_pokemon/domain/usecases/search_pokemon.dart';
import 'src/features/search_pokemon/presentation/cubit/search_pokemon_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  initExternal();
  initCore();
  initHomeFeature();
  initPokemonDetailFeature();
  initSearchPokemonFeature();
}

void initExternal(){
  //* External
  // Dio client
  sl.registerLazySingleton(() => Dio());
}

void initCore() {
   //* Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl()
  );
}

void initHomeFeature() {
  // Cubit
  sl.registerFactory(
    () => HomeCubit(
      getPokemonPageUseCase: sl()
    )
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetPokemonPage(repository: sl())
  );

  // Respository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remote: sl(), 
      networkInfo: sl()
    )
  );

  // Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dioClient: sl())
  );
}

void initPokemonDetailFeature() {
  // Cubit
  sl.registerFactory(
    () => PokemonDetailCubit(
      getPokemonDetailUseCase: sl(),
    )
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetPokemonDetail(repository: sl())
  );
  
  // Respository
  sl.registerLazySingleton<PokemonDetailRepository>(
    () => PokemonDetailRepositoryImpl(
      remote: sl(), 
      networkInfo: sl()
    )
  );

  // Data sources
  sl.registerLazySingleton<PokemonDetailRemoteDataSource>(
    () => PokemonDetailRemoteDataSourceImpl(dioClient: sl())
  );
}

void initSearchPokemonFeature() {
  // Cubit
  sl.registerFactory(
    () => SearchPokemonCubit(
      searchPokemonUseCase: sl()
    )
  );

  // Use cases
  sl.registerLazySingleton(
    () => SearchPokemon(repository: sl())
  );

  // Respository
  sl.registerLazySingleton<SearchPokemonRepository>(
    () => SearchPokemonRepositoryImpl(
      remote: sl(), 
      networkInfo: sl()
    )
  );

  // Data sources
  sl.registerLazySingleton<SearchPokemonRemoteDataSource>(
    () => SearchPokemonRemoteDataSourceImpl(dioClient: sl())
  );
}
