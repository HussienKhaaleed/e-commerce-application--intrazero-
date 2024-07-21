import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityWidgetCart extends StatefulWidget {
  const ActivityWidgetCart(
      {this.productName,
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
      this.quantity,
      this.plus,
      this.minus});
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
  final VoidCallback? plus;
  final VoidCallback? minus;
  final int? quantity;

  @override
  State<ActivityWidgetCart> createState() => _ActivityWidgetCartState();
}

class _ActivityWidgetCartState extends State<ActivityWidgetCart> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 10.h).w,
          color: Color(0xFF2A4BA0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "https://cdn-images-1.medium.com/v2/resize:fit:1200/1*5-aoK8IBmXve5whBQM90GA.png",
                    width: 87.w,
                    height: 87.h,
                  ),
                ),
                SizedBox(
                  height: 90.h,
                  width: 90.w,
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        widget.productName!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price: ${widget.price} \$',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: widget.plus,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: 30.h,
                          width: 30.w,
                          child: Center(child: Text('+')),
                        ),
                      ),
                      Text(
                        widget.quantity.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      GestureDetector(
                        onTap: widget.minus,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: 30.h,
                          width: 30.w,
                          child: Center(child: Text('-')),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.w,
                  height: 100.h,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.onPressed,
                      child: FaIcon(
                        widget.icon,
                        color: Colors.white,
                      ),
                    ),
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
