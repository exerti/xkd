import 'package:equatable/equatable.dart';

/// Home 页面状态
class HomeState extends Equatable {
  final int counter;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.counter = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  /// 复制并更新状态
  HomeState copyWith({
    int? counter,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      counter: counter ?? this.counter,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [counter, isLoading, errorMessage];
}

