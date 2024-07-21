import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intrazero/core/routers/customNavigate.dart';
import 'package:intrazero/features/Cart/Button_Widget.dart';
import 'package:intrazero/features/Home/presentation/widgets/Products_List_view.dart';
import 'package:intrazero/features/User%20Authentication/presentation/widgets/app_tect_form_field.dart';

Future<void> placeOrder(Map<String, dynamic> orderPayload) async {
  Dio dio = Dio();

  try {
    Response response =
        await dio.post('https://example.com/api/orders', data: orderPayload);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Order placed: ${response.data}');
    } else {
      print('Failed to place order: ${response.statusCode}');
    }
  } on DioException catch (e) {
    print('Dio error: ${e.message}');
  } catch (e) {
    print('Error: $e');
  }
}

class CheckoutScreen extends StatefulWidget {
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formkey = GlobalKey<FormState>();
  String? selectedValue;
  String? uid;
  String? userName;
  final List<String> _paymentOptions = ['Cash on Delivery'];
  Map<String, dynamic>? orderdetails;

  @override
  void initState() {
    super.initState();
    order();
  }

  void order() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        uid = user.uid;
        final List<Map<String, dynamic>> items = cart.map((item) {
          return {
            'product_id': item['productId'],
            'price': item['price'],
            'productName': item['productName'],
            'quantity': item['quantity'],
          };
        }).toList();
        orderdetails = {
          'items': items,
          'user_id': uid,
          'email': user.email,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2A4BA0),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checkout Details",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Color(0xFF2A4BA0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Welcome to the Checkout Details! \nThis is where you can confirm all the important information.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        hint: Text(
                          'Select Your Payment Method',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        items: _paymentOptions
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select Your Payment Method.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          orderdetails?['payment_method'] = value.toString();
                        },
                        onSaved: (value) {
                          selectedValue = value.toString();
                        },
                        buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.only(right: 8).w,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15).r,
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      textformfield(
                        hintText: "Name",
                        onChanged: (name) {
                          orderdetails?['name'] = name;
                        },
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      textformfield(
                        keyboardType: TextInputType.phone,
                        hintText: "Phone",
                        onChanged: (phone) {
                          orderdetails?['phone'] = phone;
                        },
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      textformfield(
                        hintText: "Address",
                        onChanged: (address) {
                          orderdetails?['address'] = address;
                        },
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
                ButtonWidget(
                  height: 50.h,
                  width: 345.w,
                  text: 'Confirm Checkout ',
                  backgroundColor: Color(0xFF2A4BA0),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  fontColor: Colors.white,
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await placeOrder(orderdetails ?? {});
                      customReplacementNavigate(context, '/sucessful');
                      setState(() {
                        cart.clear();
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
