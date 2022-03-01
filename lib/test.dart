import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import 'testotvet.dart';
import 'testvopros.dart';




class TestPage extends StatefulWidget {
  const TestPage({ Key? key }) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(44, 44, 44, 1),
      child: Column(
        children: const [
        Expanded(
            child: TestVopros(),
            flex: 2,
          ),
          Expanded(
              child: TestOtvet(),
              flex: 2
          ),
        ],
      ),
    );
  }
}