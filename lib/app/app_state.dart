import 'package:equatable/equatable.dart';

/// 全局用户信息
class LoginUser extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? avatarUrl;

  const LoginUser({
    required this.id,
    required this.name,
    this.email,
    this.avatarUrl,
  });

  static const _undefined = Object();

  LoginUser copyWith({
    String? id,
    String? name,
    Object? email = _undefined,
    Object? avatarUrl = _undefined,
  }) {
    return LoginUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email == _undefined ? this.email : email as String?,
      avatarUrl:
          avatarUrl == _undefined ? this.avatarUrl : avatarUrl as String?,
    );
  }

  @override
  List<Object?> get props => [id, name, email, avatarUrl];
}

/// 全局 App 状态
class AppState extends Equatable {
  final bool isInitialized;
  final bool isLoggedIn;
  final LoginUser? user;
  final String? authToken;
  final bool isLoading;
  final String? errorMessage;
  final DateTime? lastLoginAt;

  const AppState({
    this.isInitialized = false,
    this.isLoggedIn = false,
    this.user,
    this.authToken,
    this.isLoading = false,
    this.errorMessage,
    this.lastLoginAt,
  });

  static const _undefined = Object();

  AppState copyWith({
    bool? isInitialized,
    bool? isLoggedIn,
    Object? user = _undefined,
    Object? authToken = _undefined,
    bool? isLoading,
    Object? errorMessage = _undefined,
    Object? lastLoginAt = _undefined,
  }) {
    return AppState(
      isInitialized: isInitialized ?? this.isInitialized,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user == _undefined ? this.user : user as LoginUser?,
      authToken: authToken == _undefined ? this.authToken : authToken as String?,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage == _undefined ? this.errorMessage : errorMessage as String?,
      lastLoginAt:
          lastLoginAt == _undefined ? this.lastLoginAt : lastLoginAt as DateTime?,
    );
  }

  @override
  List<Object?> get props =>
      [isInitialized, isLoggedIn, user, authToken, isLoading, errorMessage, lastLoginAt];
}


