import 'features/home/domain/use_case/add_product.dart';

import 'features/home/data/repository/home_repository_impl.dart';
import 'features/home/data/sources/remote/home_remote_service.dart';
import 'features/home/domain/repository/home_repository.dart';
import 'features/home/domain/use_case/get_product.dart';
import 'package:get_it/get_it.dart';

import 'core/api_client/api_client.dart';
import 'core/config/get_platform.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/data/sources/remote/auth_remote_service.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/use_cases/forget_password.dart';
import 'features/auth/domain/use_cases/sign_out.dart';
import 'features/auth/domain/use_cases/signin.dart';
import 'features/auth/domain/use_cases/signup.dart';
import 'features/settings/data/models/settings_model.dart';
import 'features/settings/data/repositories/hive_repository_impl.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeServiceLocator() async {
  // app initializations
  sl.registerSingleton<PT>(PlatformInfo.getCurrentPlatformType());
  sl.registerSingleton<AppDir>(AppDir());
  sl.registerSingleton<AppSettings>(AppSettings());
  sl.registerSingleton<ApiClient>(ApiClient());

  //services
  sl.registerSingleton<AuthRemoteService>(AuthRemoteServiceImpl(sl()));
  sl.registerSingleton<HomeRemoteService>(HomeRemoteServiceImpl(sl()));

  // repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl(sl()));

  // use cases
  sl.registerSingleton<SigninUseCase>(SigninUseCase(sl()));
  sl.registerSingleton<SignupUseCase>(SignupUseCase(sl()));
  sl.registerSingleton<ForgetPasswordUseCase>(ForgetPasswordUseCase(sl()));
  sl.registerSingleton<SignoutUseCase>(SignoutUseCase(sl()));
  sl.registerSingleton<GetProductUseCase>(GetProductUseCase(sl()));
  sl.registerSingleton<AddProductUseCase>(AddProductUseCase(sl()));
}
