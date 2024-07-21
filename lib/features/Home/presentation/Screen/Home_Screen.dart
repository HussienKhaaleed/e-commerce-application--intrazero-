import 'package:flutter/material.dart';
import 'package:intrazero/features/Home/presentation/widgets/Home_Body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  HomeBody();
  }
}
