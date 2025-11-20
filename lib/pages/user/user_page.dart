import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'user_cubit.dart';
import 'user_state.dart';

/// User 页面
/// 使用 BLoC 的 Cubit 和 State 进行状态管理
/// 使用 GetX 进行路由返回
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 BlocProvider 提供 Cubit
    return BlocProvider(
      create: (context) => UserCubit()..loadUserInfo(),
      child: const _UserPageView(),
    );
  }
}

class _UserPageView extends StatelessWidget {
  const _UserPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 使用 GetX 返回上一页
            Get.back();
          },
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                        
                        // 显示用户信息
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '用户名: ${state.userName ?? "未设置"}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '邮箱: ${state.userEmail ?? "未设置"}',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // 操作按钮
                        ElevatedButton(
                          onPressed: () {
                            context.read<UserCubit>().updateUserName('李四');
                          },
                          child: const Text('更新用户名'),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        ElevatedButton(
                          onPressed: () {
                            context.read<UserCubit>().updateUserEmail('lisi@example.com');
                          },
                          child: const Text('更新邮箱'),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        ElevatedButton(
                          onPressed: () {
                            context.read<UserCubit>().clearUserInfo();
                          },
                          child: const Text('清除信息'),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        ElevatedButton(
                          onPressed: () {
                            context.read<UserCubit>().loadUserInfo();
                          },
                          child: const Text('重新加载'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

