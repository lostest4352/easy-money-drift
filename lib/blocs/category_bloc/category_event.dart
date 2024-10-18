part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class CategoryInitialEvent extends CategoryEvent {}

final class CategoryAddEvent extends CategoryEvent {
  final CategoryModelDriftCompanion categoryModelDriftCompanion;

  CategoryAddEvent({required this.categoryModelDriftCompanion});
}

final class CategoryEditEvent extends CategoryEvent {
  final CategoryModel oldCategoryModel;
  final CategoryModel newCategoryModel;

  CategoryEditEvent(
      {required this.oldCategoryModel, required this.newCategoryModel});
}

final class CategoryDeleteEvent extends CategoryEvent {
  final CategoryModel categoryModel;

  CategoryDeleteEvent({required this.categoryModel});
}

final class CategoryAddDefaultItemsEvent extends CategoryEvent {}
