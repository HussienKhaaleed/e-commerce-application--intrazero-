import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intrazero/core/routers/customNavigate.dart';
import 'package:intrazero/features/Home/presentation/widgets/Drawer_NavBar.dart';
import 'package:intrazero/features/Home/presentation/widgets/Products_List_view.dart';
import 'package:intrazero/features/Home/presentation/widgets/home_top_text.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DrawerNavBar(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.cartShopping),
              onPressed: () {
                customNavigate(context, "/cart");
              },
            ),
          ],
          centerTitle: true,
          title: Text(
            "intrazero",
            style: TextStyle(
              fontSize: 24.sp,
              color: const Color(0xFF2A4BA0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height * 0.9.h,
          child: Column(
            children: [
              HomeTopText(),
              Flexible(child: ProductListScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
