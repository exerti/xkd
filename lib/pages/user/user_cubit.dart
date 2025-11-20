import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_state.dart';

/// User 页面 Cubit
/// 负责管理 User 页面的业务逻辑和状态
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  /// 加载用户信息
  Future<void> loadUserInfo() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    
    try {
      // 模拟网络请求
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟成功获取数据
      emit(state.copyWith(
        userName: '张三',
        userEmail: 'zhangsan@example.com',
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  /// 更新用户名
  void updateUserName(String name) {
    emit(state.copyWith(userName: name));
  }

  /// 更新用户邮箱
  void updateUserEmail(String email) {
    emit(state.copyWith(userEmail: email));
  }

  /// 清除用户信息
  void clearUserInfo() {
    emit(const UserState());
  }
}

