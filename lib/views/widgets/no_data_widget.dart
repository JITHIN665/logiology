import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset('assets/animations/no_data.json', width: 180, height: 180));
  }
}
