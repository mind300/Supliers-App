part of 'add_offer_cubit.dart';

@immutable
sealed class AddOfferState {}

final class AddOfferInitial extends AddOfferState {}

final class AddOfferImagePicked extends AddOfferState {}

final class AddOfferLoading extends AddOfferState {}

final class AddOfferSuccess extends AddOfferState {
  final String message;

  AddOfferSuccess(this.message);
}

final class AddOfferError extends AddOfferState {
  final String message;

  AddOfferError(this.message);
}

final class AddOfferCategoriesLoaded extends AddOfferState {
  final CategoriesList categoriesList;

  AddOfferCategoriesLoaded(this.categoriesList);
}

final class AddOfferCategorySelected extends AddOfferState {
  final int categoryId;

  AddOfferCategorySelected(this.categoryId);
}

//cat loading
final class AddOfferCategoriesLoading extends AddOfferState {}

final class AddOfferCategoryError extends AddOfferState {
  final String message;

  AddOfferCategoryError(this.message);
}

//AddOfferCategoryChanged
final class AddOfferCategoryChanged extends AddOfferState {
  AddOfferCategoryChanged();
}
