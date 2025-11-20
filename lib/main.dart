import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:get/get.dart';
import 'package:xkd/utils/xkd_log.dart';

import 'config/buggly.config.dart';
import 'routes/app_routes.dart';

void main() {
  FlutterBugly.postCatchedException(() async {
    WidgetsFlutterBinding.ensureInitialized();
    _configureImageCache();
    _setupErrorHandling();
    await BuglyConfig.init();
    runApp(const MyApp());
  });
}

void _configureImageCache() {
  PaintingBinding.instance.imageCache.maximumSize = 500; //最多500张
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20; //最大50M
}

void _setupErrorHandling() {
  FlutterError.onError = (details) async {
    await BuglyConfig.handleException(details.exception, details.stack);
  };

  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    BuglyConfig.handleException(error, stack);
    return true;
  };
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
      enableLog: false,
      // 路由切换日志
      routingCallback: _logRouteChange,
    );
  }
}

void _logRouteChange(Routing? routing) {
  if (routing == null) return;

  final buffer = StringBuffer()
    ..writeln('--- Route Change ---')
    ..writeln('From: ${routing.previous}')
    ..writeln('To: ${routing.current}')
    ..writeln('Action: ${routing.isBack == true ? 'pop/back' : 'push'}')
    ..writeln('Arguments: ${routing.args ?? '无'}');
  XKDLog.info(buffer.toString());
}
