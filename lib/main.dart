import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intrazero/core/helper/cashe_helper.dart';
import 'package:intrazero/core/routers/app_router.dart';
import 'package:intrazero/core/service/service_locter.dart';
import 'package:intrazero/firebase_options.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await getIt<CacheHelper>().init();
  runApp(const intrazeroApp());
}

class intrazeroApp extends StatelessWidget {
  const intrazeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
        );
      },
    );
  }
}
