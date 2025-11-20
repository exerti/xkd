import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'XKD App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // 初始路由
      initialRoute: AppRoutes.home,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      // 路由配置
      getPages: AppRoutes.routes,
    );
  }
}
