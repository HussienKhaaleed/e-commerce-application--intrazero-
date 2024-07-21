import '../../data/models/home_data_model.dart';

class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {
  get products => null;
}

class ProductSuccess extends ProductState {
  final List<HomeProductsModel> products;

  ProductSuccess(this.products);
}

class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);
}
