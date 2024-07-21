import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intrazero/features/Home/data/models/home_data_model.dart';
import 'package:intrazero/features/Home/presentation/widgets/Products_List_view.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/custom_toast.dart';

class ProductDetailScreen extends StatefulWidget {
  final HomeProductsModel product;

  ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF2A4BA0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.product.name!,
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10.h),
              Image.network(
                "https://cdn-images-1.medium.com/v2/resize:fit:1200/1*5-aoK8IBmXve5whBQM90GA.png",
                width: 375.w,
                height: 391.h,
              ),
              SizedBox(height: 10.h),
              Column(
                children: [
                  Text(
                    ' Description: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.description!,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Rating: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: widget.product.rating!.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) {},
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    'Brand: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.brand!,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    'Unit: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.unit!,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    'Availability: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.product.availability.toString() == true
                        ? 'Out of Stock'
                        : 'In Stock',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Text(
                    'Price: ',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${widget.product.price!.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(375.w, 50.h),
                  backgroundColor: Color(0xFF2A4BA0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                ),
                onPressed: () {
                  setState(() {
                    Map<String, dynamic> productItem = {
                      "quantity": 1,
                      "availability": '${widget.product.availability}',
                      "unit": '${widget.product.unit}',
                      "productId": '${widget.product.productId}',
                      "productName": '${widget.product.name}',
                      "price": '${widget.product.price}',
                    };
                    bool isProductInCart = cart.any((productId) =>
                        productId["productId"] == productItem['productId']);
                    if (isProductInCart) {
                      showToast('Item Already Added', Colors.white);
                    } else if (widget.product.availability == false ||
                        widget.product.unit == "0") {
                      showToast('Out of Stock', Colors.white);
                    } else {
                      cart.add(productItem);
                      showToast('Item Added To Cart', Colors.white);
                    }
                  });
                },
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
