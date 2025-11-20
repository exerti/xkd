import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

/// 路由页面基类（StatefulWidget）
/// 支持：
/// 1. 获取 GetX 路由参数（通过 arguments）
/// 2. 在 initState 中初始化 Cubit（可以传入路由参数，如 xxx_id）
/// 3. 支持动画控制器等生命周期管理（需要时在 State 中混入 TickerProviderStateMixin）
/// 
/// 使用示例（不需要动画）：
/// ```dart
/// class ExamplePage extends RouterPage<ExampleCubit, ExampleState> {
///   const ExamplePage({super.key});
/// 
///   @override
///   ExampleCubit createCubit(Map<String, dynamic>? arguments) {
///     final itemId = arguments?['item_id'] as int?;
///     return ExampleCubit(itemId: itemId);
///   }
/// 
///   @override
///   void initState(ExampleCubit cubit, Map<String, dynamic>? arguments) {
///     super.initState(cubit, arguments);
///     // 可以调用 cubit 的初始化方法
///     // cubit.loadData();
///   }
/// 
///   @override
///   Widget buildPage(BuildContext context, ExampleCubit cubit, ExampleState state) {
///     return Scaffold(...);
///   }
/// }
/// ```
/// 
/// 使用示例（需要动画）：
/// 如果需要动画控制器，需要重写 createState 方法，返回一个混入了 TickerProviderStateMixin 的 State：
/// ```dart
/// class ExamplePage extends RouterPage<ExampleCubit, ExampleState> {
///   const ExamplePage({super.key});
/// 
///   @override
///   State<RouterPage<ExampleCubit, ExampleState>> createState() {
///     return _ExamplePageState();
///   }
/// 
///   @override
///   ExampleCubit createCubit(Map<String, dynamic>? arguments) {
///     final itemId = arguments?['item_id'] as int?;
///     return ExampleCubit(itemId: itemId);
///   }
/// 
///   @override
///   void initState(ExampleCubit cubit, Map<String, dynamic>? arguments) {
///     super.initState(cubit, arguments);
///     // 在 State 中可以使用 this 作为 TickerProvider
///   }
/// 
///   @override
///   Widget buildPage(BuildContext context, ExampleCubit cubit, ExampleState state) {
///     return Scaffold(...);
///   }
/// }
/// 
/// class _ExamplePageState extends _RouterPageState<ExampleCubit, ExampleState>
///     with SingleTickerProviderStateMixin {
///   @override
///   void initState() {
///     super.initState();
///     // 现在可以使用 this 作为 TickerProvider
///     animationController = AnimationController(
///       vsync: this,
///       duration: const Duration(seconds: 1),
///     );
///   }
/// 
///   @override
///   void dispose() {
///     animationController?.dispose();
///     super.dispose();
///   }
/// }
/// ```
abstract class RouterPage<C extends Cubit<S>, S> extends StatefulWidget {
  const RouterPage({super.key});

  /// 创建 Cubit 实例
  /// [arguments] 是从 GetX 路由传递过来的参数
  C createCubit(Map<String, dynamic>? arguments);

  /// 初始化状态
  /// 在 initState 中调用，可以在这里初始化动画控制器等
  /// [cubit] 是创建的 Cubit 实例
  /// [arguments] 是路由参数
  void initState(C cubit, Map<String, dynamic>? arguments) {}

  /// 构建页面内容
  /// [context] BuildContext
  /// [cubit] Cubit 实例
  /// [state] 当前状态
  Widget buildPage(BuildContext context, C cubit, S state);

  /// 清理资源
  /// 在 dispose 中调用，可以在这里释放动画控制器等
  /// [cubit] Cubit 实例
  void dispose(C cubit) {}

  @override
  State<RouterPage<C, S>> createState() => RouterPageState<C, S>();
}

/// RouterPage 的 State 基类
/// 如果需要动画，可以继承此类并混入 TickerProviderStateMixin 或 SingleTickerProviderStateMixin
/// 
/// 示例：
/// ```dart
/// class _ExamplePageState extends RouterPageState<ExampleCubit, ExampleState>
///     with SingleTickerProviderStateMixin {
///   @override
///   void initState() {
///     super.initState();
///     // 可以使用 this 作为 TickerProvider
///     animationController = AnimationController(
///       vsync: this,
///       duration: const Duration(seconds: 1),
///     );
///   }
/// }
/// ```
class RouterPageState<C extends Cubit<S>, S>
    extends State<RouterPage<C, S>> {
  late C cubit;
  Map<String, dynamic>? arguments;

  @override
  void initState() {
    super.initState();
    // 获取 GetX 路由参数
    arguments = Get.arguments as Map<String, dynamic>?;
    // 创建 Cubit
    cubit = widget.createCubit(arguments);
    // 调用子类的 initState
    widget.initState(cubit, arguments);
  }

  @override
  void dispose() {
    // 调用子类的 dispose
    widget.dispose(cubit);
    // 关闭 Cubit
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<C>.value(
      value: cubit,
      child: BlocBuilder<C, S>(
        builder: (context, state) {
          return widget.buildPage(context, cubit, state);
        },
      ),
    );
  }
}

