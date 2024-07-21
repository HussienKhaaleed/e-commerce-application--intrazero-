import 'package:get_it/get_it.dart';
import 'package:intrazero/core/helper/cashe_helper.dart';
import 'package:intrazero/features/Home/data/API/ApiService.dart';
import 'package:intrazero/features/Home/view_model/cubit/product_cubit.dart';
import 'package:intrazero/features/User%20Authentication/presentation/view_model/cubit/user_authentication_cubit.dart';

final getIt = GetIt.instance;

void setupServiceLocter() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<UserAuthenticationCubit>(UserAuthenticationCubit());
  getIt.registerSingleton<ProductCubit>(
      ProductCubit(ApiService())..fetchProducts());
}
