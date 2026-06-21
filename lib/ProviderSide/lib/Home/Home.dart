import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/cards.dart';
import 'FirstTime.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          WelcomeCard(context:context, userName: 'flower'),
          SizedBox(height:10,),
          Expanded(child: Firsttime())

        ],
      ),
    );
  }
}
