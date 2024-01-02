import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Lottie.asset('Assetes/animation/empty.json',)),
        Text('Empty List Please Create new List'),
      ],
    );
  }
}
