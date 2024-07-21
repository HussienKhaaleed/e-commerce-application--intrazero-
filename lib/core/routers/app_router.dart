import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intrazero/core/service/service_locter.dart';
import 'package:intrazero/features/Cart/Cart_Screen.dart';
import 'package:intrazero/features/Cart/Checkout_Screen.dart';
import 'package:intrazero/features/Cart/Sucssesful_Screen.dart';
import 'package:intrazero/features/Home/presentation/Screen/Home_Screen.dart';
import 'package:intrazero/features/Home/view_model/cubit/product_cubit.dart';
import 'package:intrazero/features/Loding%20Screen/Loding_Screen.dart';
import 'package:intrazero/features/User%20Authentication/presentation/Screen/forget_password_Screen.dart';
import 'package:intrazero/features/User%20Authentication/presentation/Screen/login_Screen.dart';
import 'package:intrazero/features/User%20Authentication/presentation/Screen/register_Screen.dart';
import 'package:intrazero/features/User%20Authentication/presentation/view_model/cubit/user_authentication_cubit.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, State) => LodingScreen(),
      ),
      GoRoute(
        path: "/register",
        builder: (context, State) => BlocProvider(
          create: (context) => getIt<UserAuthenticationCubit>(),
          child: const registerView(),
        ),
      ),
      GoRoute(
        path: "/login",
        builder: (context, State) => BlocProvider(
          create: (context) => getIt<UserAuthenticationCubit>(),
          child: const loginnView(),
        ),
      ),
      GoRoute(
        path: "/forgetpassword",
        builder: (context, State) => BlocProvider(
          create: (context) => getIt<UserAuthenticationCubit>(),
          child: forgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: "/home",
        builder: (context, State) => BlocProvider(
          create: (context) => getIt<ProductCubit>(),
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: "/cart",
        builder: (context, State) => const CartScreen(),
      ),
      GoRoute(
        path: "/checkout",
        builder: (context, State) => CheckoutScreen(),
      ),
      GoRoute(
        path: "/sucessful",
        builder: (context, State) => SucssesfulScreen(),
      ),
    ],
  );
}
