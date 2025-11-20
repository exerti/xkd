import 'package:flutter_bloc/flutter_bloc.dart';
import 'example_state.dart';

/// Example 页面 Cubit
/// 负责管理 Example 页面的业务逻辑和状态
class ExampleCubit extends Cubit<ExampleState> {
  ExampleCubit({int? itemId}) : super(ExampleState(itemId: itemId)) {
    // 如果有 itemId，自动加载数据
    if (itemId != null) {
      loadItemData(itemId);
    }
  }

  /// 加载项目数据
  Future<void> loadItemData(int itemId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟成功获取数据
      emit(state.copyWith(
        itemId: itemId,
        itemName: '项目 $itemId',
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  /// 更新项目名称
  void updateItemName(String name) {
    emit(state.copyWith(itemName: name));
  }

  /// 更新动画值
  void updateAnimationValue(double value) {
    emit(state.copyWith(animationValue: value));
  }

  /// 清除数据
  void clearData() {
    emit(const ExampleState());
  }
}

