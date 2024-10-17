part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class CategoryInitialEvent extends CategoryEvent {}

final class CategoryAddEvent extends CategoryEvent {
  final CategoryModelDriftCompanion categoryModelDriftCompanion;

  CategoryAddEvent({required this.categoryModelDriftCompanion});
}

final class CategoryEditEvent extends CategoryEvent {
  final CategoryModelDriftData categoryModelDriftData;

  CategoryEditEvent({required this.categoryModelDriftData});
}

final class CategoryDeleteEvent extends CategoryEvent {
  final CategoryModel categoryModel;

  CategoryDeleteEvent({required this.categoryModel});
}

final class CategoryAddDefaultItemsEvent extends CategoryEvent {}
