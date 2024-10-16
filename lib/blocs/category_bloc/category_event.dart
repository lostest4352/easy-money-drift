part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class CategoryInitialEvent extends CategoryEvent {}

final class CategoryAddEvent extends CategoryEvent {
  final CategoryModelIsar categoryModelIsars;

  CategoryAddEvent({required this.categoryModelIsars});
}

final class CategoryEditEvent extends CategoryEvent {
  final CategoryModelIsar selectedCategoryModelIsar;
  final int selectedCategoryModelId;
  final String transactionType;
  final bool isIncome;
  final int colorsValue;

  CategoryEditEvent({
    required this.selectedCategoryModelIsar,
    required this.selectedCategoryModelId,
    required this.transactionType,
    required this.isIncome,
    required this.colorsValue,
  });
}

final class CategoryDeleteEvent extends CategoryEvent {
  final CategoryModelIsar selectedCategoryModelIsar;

  CategoryDeleteEvent({required this.selectedCategoryModelIsar});
}

final class CategoryAddDefaultItemsEvent extends CategoryEvent {}
