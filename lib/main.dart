import 'src/feature/auth/widget/sign_success_screen.dart';
import 'src/feature/navigation_bar_screen/view/navigation_bar_screen.dart';

import 'src/feature/home/view/home_screen.dart';
import 'src/utils/app_theme.dart';
import 'src/feature/auth/login/view/login_screen.dart';
import 'src/feature/auth/register/view/register_screen.dart';
import 'init_screen.dart';
import 'src/feature/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const EcommerceRouteApp());
}

class EcommerceRouteApp extends StatelessWidget {
  const EcommerceRouteApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          initialRoute: NavigationBarScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
            InitScreen.routeName: (context) => InitScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            RegisterScreen.routeName: (context) => RegisterScreen(),
            SuccessScreen.routeName: (context) => SuccessScreen(),
            NavigationBarScreen.routeName: (context) => NavigationBarScreen(),
          },
        );
      },
    );
  }
}
