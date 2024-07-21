import 'package:bloc/bloc.dart';
import 'package:intrazero/features/Home/data/API/ApiService.dart';
import 'package:intrazero/features/Home/data/models/home_data_model.dart';
import 'package:intrazero/features/Home/view_model/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;
  List<HomeProductsModel> allProducts = [];
  int currentPage = 1;
  bool isFetching = false;

  ProductCubit(this.apiService) : super(ProductInitial());

  Future<void> fetchProducts({int page = 1}) async {
    try {
      if (page == 1) {
        emit(ProductLoading());
      }
      isFetching = true;
      final products = await apiService.fetchProducts(page);
      if (page == 1) {
        allProducts = products;
      } else {
        allProducts.addAll(products);
      }
      emit(ProductSuccess(allProducts));
      isFetching = false;
    } catch (e) {
      emit(ProductFailure(e.toString()));
      isFetching = false;
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(ProductSuccess(allProducts));
    } else {
      final filteredProducts = allProducts
          .where((product) =>
              product.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ProductSuccess(filteredProducts));
    }
  }

  void retry() {
    fetchProducts(page: currentPage);
  }

  void loadMore() {
    if (!isFetching) {
      currentPage++;
      fetchProducts(page: currentPage);
    }
  }

  void filterProducts(String category) {
    if (category.isEmpty) {
      emit(ProductSuccess(allProducts));
    } else {
      final filteredProducts =
          allProducts.where((product) => product.category == category).toList();
      emit(ProductSuccess(filteredProducts));
    }
  }
}
