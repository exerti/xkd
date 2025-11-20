import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/xkd_log.dart';
import 'app_state.dart';

export 'app_state.dart';

/// App 级别的全局 Cubit，用来记录用户登录信息
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  /// 初始化应用，后续可以在这里恢复本地缓存的会话信息
  Future<void> initialize() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(isInitialized: true, isLoading: false));
  }

  /// 登录成功后记录用户信息
  Future<void> login({
    required String userId,
    required String userName,
    required String token,
    String? email,
    String? avatarUrl,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await Future<void>.delayed(const Duration(milliseconds: 400));

      final user = LoginUser(
        id: userId,
        name: userName,
        email: email,
        avatarUrl: avatarUrl,
      );

      emit(
        state.copyWith(
          isLoading: false,
          isLoggedIn: true,
          user: user,
          authToken: token,
          lastLoginAt: DateTime.now(),
        ),
      );
    } catch (e, s) {
      XKDLog.error('登录失败: $e', e, s);
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// 更新用户资料
  void updateUserProfile({
    String? userName,
    String? email,
    String? avatarUrl,
  }) {
    final currentUser = state.user;
    if (currentUser == null) {
      return;
    }

    final updatedUser = currentUser.copyWith(
      name: userName,
      email: email,
      avatarUrl: avatarUrl,
    );

    emit(state.copyWith(user: updatedUser));
  }

  /// 刷新 token
  void updateToken(String token) {
    emit(state.copyWith(authToken: token));
  }

  /// 退出登录并清空用户信息
  void logout() {
    emit(
      state.copyWith(
        isLoggedIn: false,
        user: null,
        authToken: null,
        lastLoginAt: null,
        errorMessage: null,
      ),
    );
  }
}


