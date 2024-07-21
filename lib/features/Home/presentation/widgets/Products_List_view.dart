import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intrazero/features/Home/presentation/widgets/ActivityWidget.dart';
import 'package:intrazero/features/Home/presentation/widgets/Product_Detail_Screen.dart';
import 'package:intrazero/features/Home/view_model/cubit/product_cubit.dart';
import 'package:intrazero/features/Home/view_model/cubit/product_state.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/custom_toast.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

var cart = [];

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductSuccess) {
            return LazyLoadScrollView(
              isLoading: false,
              onEndOfPage: () {
                if (state.products.isNotEmpty) {
                  showToast("No more products", Colors.white);
                } else {
                  context.read<ProductCubit>().fetchProducts();
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9.h,
                child: SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: List.generate(
                      state.products.length,
                      (index) {
                        final product = state.products[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ActivityWidget(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailScreen(product: product),
                                ),
                              );
                            },
                            text: 'Add to cart',
                            productId: product.productId,
                            icon: Icons.add_shopping_cart,
                            productName: product.name,
                            url:
                                "https://cdn-images-1.medium.com/v2/resize:fit:1200/1*5-aoK8IBmXve5whBQM90GA.png",
                            price: product.price.toString(),
                            onPressed: () {
                              setState(() {
                                Map<String, dynamic> productItem = {
                                  "quantity": 1,
                                  "availability": '${product.availability}',
                                  "unit": '${product.unit}',
                                  "productId": '${product.productId}',
                                  "productName": '${product.name}',
                                  "price": '${product.price}',
                                };
                                bool isProductInCart = cart.any((productId) =>
                                    productId["productId"] ==
                                    productItem['productId']);
                                if (isProductInCart) {
                                  showToast('Item Already Added', Colors.white);
                                } else if (product.availability == false ||
                                    product.unit == "0") {
                                  showToast('Out of Stock', Colors.white);
                                } else {
                                  cart.add(productItem);
                                  showToast('Item Added To Cart', Colors.white);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          } else if (state is ProductFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProductCubit>().fetchProducts(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}
