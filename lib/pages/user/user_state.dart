import 'package:equatable/equatable.dart';

/// User 页面状态
class UserState extends Equatable {
  final String? userName;
  final String? userEmail;
  final bool isLoading;
  final String? errorMessage;

  const UserState({
    this.userName,
    this.userEmail,
    this.isLoading = false,
    this.errorMessage,
  });

  /// 复制并更新状态
  UserState copyWith({
    String? userName,
    String? userEmail,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UserState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [userName, userEmail, isLoading, errorMessage];
}

