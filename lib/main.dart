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
      // 去掉 GetX 右滑切换时的黑边，使用纯右滑转场
      defaultTransition: Transition.rightToLeft,
      // 路由配置
      getPages: AppRoutes.routes,
      // 路由切换日志
      routingCallback: _logRouteChange,
    );
  }
}

void _logRouteChange(Routing? routing) {
  if (routing == null) return;

  final buffer = StringBuffer()
    ..writeln('--- Route Change ---')
    ..writeln('From: ${routing.previous ?? 'unknown'}')
    ..writeln('To: ${routing.current ?? 'unknown'}')
    ..writeln('Action: ${routing.isBack == true ? 'pop/back' : 'push'}')
    ..writeln('Arguments: ${routing.args ?? '无'}');

  debugPrint(buffer.toString());
}
