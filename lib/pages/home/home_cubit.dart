import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

/// Home 页面 Cubit
/// 负责管理 Home 页面的业务逻辑和状态
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  /// 增加计数器
  void increment() {
    emit(state.copyWith(counter: state.counter + 1));
  }

  /// 减少计数器
  void decrement() {
    emit(state.copyWith(counter: state.counter - 1));
  }

  /// 重置计数器
  void reset() {
    emit(state.copyWith(counter: 0));
  }

  /// 模拟异步加载
  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 2));
      
      // 模拟成功
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}

