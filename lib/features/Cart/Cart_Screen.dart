import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intrazero/core/routers/customNavigate.dart';
import 'package:intrazero/features/Cart/ActivityWidget_Cart.dart';
import 'package:intrazero/features/Home/presentation/widgets/Products_List_view.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/custom_toast.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2A4BA0),
          title: Text(
            'Cart',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: cart.length,
                itemBuilder: (BuildContext, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ).w,
                    child: ActivityWidgetCart(
                      plus: () {
                        setState(() {
                          cart[index]['quantity'] += 1;
                        });
                      },
                      minus: () {
                        setState(() {
                          if (cart[index]['quantity'] > 1) {
                            cart[index]['quantity'] -= 1;
                          }
                        });
                      },
                      icon: FontAwesomeIcons.trash,
                      onPressed: () {
                        setState(() {
                          cart.removeAt(cart.indexOf(cart[index]));
                        });
                      },
                      productId: cart[index]['id'],
                      quantity: cart[index]['quantity'],
                      productName: cart[index]['productName'],
                      price: cart[index]['price'],
                      url: cart[index]['url'],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 30,
                  right: 20,
                ).w,
                child: Row(
                  children: [
                    Text(
                      "Total Items : ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Color(0xFF2A4BA0),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    Text(
                      cart
                          .fold<int>(
                              0, (sum, item) => sum + (item['quantity'] as int))
                          .toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Color(0xFF2A4BA0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 30,
                  right: 20,
                ).w,
                child: Row(
                  children: [
                    Text(
                      'Total Price : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Color(0xFF2A4BA0),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    Text(
                      totalpricee().toStringAsFixed(2) ?? '0',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Color(0xFF2A4BA0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20).w,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 30).w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2A4BA0),
                        ),
                        onPressed: () {
                          if (cart.length != 0) {
                            customNavigate(context, '/checkout');
                          } else {
                            showToast('Cart is empty', Colors.white);
                          }
                        },
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double totalpricee() {
  double total = 0;
  for (var item in cart) {
    total += item['quantity'] * double.parse(item['price']);
  }
  return total;
}
