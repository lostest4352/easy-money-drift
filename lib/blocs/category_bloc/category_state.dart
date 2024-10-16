part of 'category_bloc.dart';

enum SnackBarStatus {
  isShown,
  isNotShown,
}

final class CategoryState with EquatableMixin {
  final List<CategoryModelIsar>? listOfCategoryData;
  final SnackBarStatus snackBarStatus;

  CategoryState({
    required this.listOfCategoryData,
    this.snackBarStatus = SnackBarStatus.isNotShown,
  });

  CategoryState copyWith({
    List<CategoryModelIsar>? listOfCategoryData,
    SnackBarStatus? snackBarStatus,
  }) {
    return CategoryState(
      listOfCategoryData: listOfCategoryData ?? this.listOfCategoryData,
      snackBarStatus: snackBarStatus ?? this.snackBarStatus,
    );
  }

  @override
  List<Object?> get props => [listOfCategoryData, snackBarStatus];
}
