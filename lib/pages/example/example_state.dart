import 'package:equatable/equatable.dart';

/// Example 页面状态
class ExampleState extends Equatable {
  final int? itemId;
  final String? itemName;
  final bool isLoading;
  final String? errorMessage;
  final double animationValue;

  const ExampleState({
    this.itemId,
    this.itemName,
    this.isLoading = false,
    this.errorMessage,
    this.animationValue = 0.0,
  });

  /// 复制并更新状态
  ExampleState copyWith({
    int? itemId,
    String? itemName,
    bool? isLoading,
    String? errorMessage,
    double? animationValue,
  }) {
    return ExampleState(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      animationValue: animationValue ?? this.animationValue,
    );
  }

  @override
  List<Object?> get props => [itemId, itemName, isLoading, errorMessage, animationValue];
}

