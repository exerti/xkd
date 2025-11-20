import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'home_cubit.dart';
import 'home_state.dart';
import '../../routes/app_routes.dart';

/// Home 页面
/// 使用 BLoC 的 Cubit 和 State 进行状态管理
/// 使用 GetX 进行路由跳转
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 BlocProvider 提供 Cubit
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 显示加载状态
                if (state.isLoading)
                  const CircularProgressIndicator()
                else
                  Column(
                    children: [
                      // 显示错误信息
                      if (state.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            state.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      // 显示计数器
                      Text(
                        '计数器: ${state.counter}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      const SizedBox(height: 20),

                      // 操作按钮
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                context.read<HomeCubit>().decrement(),
                            child: const Text('-'),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () => context.read<HomeCubit>().reset(),
                            child: const Text('重置'),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<HomeCubit>().increment(),
                            child: const Text('+'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // 加载数据按钮
                      ElevatedButton(
                        onPressed: () => context.read<HomeCubit>().loadData(),
                        child: const Text('加载数据'),
                      ),

                      const SizedBox(height: 40),

                      // 跳转到用户页面（使用 GetX 路由）
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.user,
                            arguments: {"projectId": 106},
                          );
                        },
                        child: const Text('跳转到用户页面'),
                      ),

                      const SizedBox(height: 10),

                      // 跳转到示例页面（使用 RouterPage 基类）
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.example,
                            arguments: {
                              'item_id': 100,
                            },
                          );
                        },
                        child: const Text('跳转到示例页面（带参数）'),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
