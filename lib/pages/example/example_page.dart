import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/router_page.dart';
import '../../routes/app_routes.dart';
import 'example_cubit.dart';
import 'example_state.dart';

/// Example 页面的 State 类
/// 混入 SingleTickerProviderStateMixin 以支持动画控制器
class _ExamplePageState extends RouterPageState<ExampleCubit, ExampleState>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器（使用 this 作为 TickerProvider）
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    
    // 监听动画值变化并更新到 Cubit
    _animationController.addListener(() {
      cubit.updateAnimationValue(_animationController.value);
    });
    
    // 启动动画
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // 释放动画控制器
    _animationController.dispose();
    super.dispose();
  }

  // 不需要重写 build 方法，父类已经处理了 BlocProvider 和 BlocBuilder
  // 如果需要使用动画，可以在 buildPage 中通过 state 访问动画值
}

/// Example 页面
/// 展示如何使用 RouterPage 基类
/// 支持：
/// 1. 从路由参数获取数据（如 item_id）
/// 2. 在 initState 中初始化动画控制器
/// 3. 在 dispose 中释放资源
/// 
/// 注意：如果需要动画，需要重写 createState 并混入 TickerProviderStateMixin
class ExamplePage extends RouterPage<ExampleCubit, ExampleState> {
  const ExamplePage({super.key});

  @override
  State<RouterPage<ExampleCubit, ExampleState>> createState() {
    return _ExamplePageState();
  }

  @override
  ExampleCubit createCubit(Map<String, dynamic>? arguments) {
    // 从路由参数中获取 item_id
    final itemId = arguments?['item_id'] as int?;
    // 创建 Cubit 并传入参数
    return ExampleCubit(itemId: itemId);
  }

  @override
  void initState(ExampleCubit cubit, Map<String, dynamic>? arguments) {
    super.initState(cubit, arguments);
    // 可以在这里调用 cubit 的其他初始化方法
    // cubit.loadData();
  }

  @override
  Widget buildPage(BuildContext context, ExampleCubit cubit, ExampleState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 使用 GetX 返回上一页
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 显示路由参数信息
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '路由参数示例',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Item ID: ${state.itemId ?? "未传递"}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
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
                    
                    // 显示项目信息（使用动画）
                    // 动画值通过 state 传递（在 State 的 initState 中更新）
                    // BlocBuilder 会在 state 变化时自动重建
                    if (state.itemName != null)
                      Transform.scale(
                        scale: 0.8 + state.animationValue * 0.2,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '项目名称: ${state.itemName}',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '动画值: ${state.animationValue.toStringAsFixed(2)}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    
                    const SizedBox(height: 20),
                    
                    // 操作按钮
                    ElevatedButton(
                      onPressed: () {
                        cubit.updateItemName('新项目名称');
                      },
                      child: const Text('更新项目名称'),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    ElevatedButton(
                      onPressed: () {
                        cubit.updateAnimationValue(0.5);
                      },
                      child: const Text('更新动画值'),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    ElevatedButton(
                      onPressed: () {
                        cubit.clearData();
                      },
                      child: const Text('清除数据'),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    if (state.itemId != null)
                      ElevatedButton(
                        onPressed: () {
                          cubit.loadItemData(state.itemId!);
                        },
                        child: const Text('重新加载'),
                      ),
                  ],
                ),
              
              const SizedBox(height: 40),
              
              // 演示如何传递参数跳转
              ElevatedButton(
                onPressed: () {
                  // 传递参数跳转到 Example 页面
                  Get.toNamed(
                    AppRoutes.example,
                    arguments: {
                      'item_id': 123,
                    },
                  );
                },
                child: const Text('跳转到 Example (带参数)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

