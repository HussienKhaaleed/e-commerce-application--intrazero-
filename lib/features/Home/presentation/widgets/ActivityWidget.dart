import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    this.productName,
    super.key,
    this.url,
    this.price,
    this.elevatedButton,
    this.onPressed,
    this.text,
    this.icon,
    this.productDescription,
    this.onTap,
    this.productId,
  });
  final int? productId;
  final String? url;
  final String? productName;
  final String? productDescription;
  final ElevatedButton? elevatedButton;
  final String? price;
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          color: Color(0xFF2A4BA0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "https://cdn-images-1.medium.com/v2/resize:fit:1200/1*5-aoK8IBmXve5whBQM90GA.png",
                    width: 100.w,
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  productName!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        'Price: $price \$',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: onPressed,
                              child: Row(
                                children: [
                                  Text(
                                    '$text  ',
                                    style: const TextStyle(
                                        color: Color(0xFF2A4BA0)),
                                  ),
                                  Icon(
                                    icon,
                                    color: const Color(0xFF2A4BA0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
