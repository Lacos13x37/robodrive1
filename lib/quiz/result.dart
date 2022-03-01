import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:robodrive/allresult.dart';
import 'package:robodrive/main.dart';
import 'package:robodrive/model/testResult.dart';
import 'dart:ui';
import 'CustomButton.dart';
import 'package:flutter/services.dart';

class ResultTest extends StatefulWidget {
  const ResultTest({Key? key}) : super(key: key);

  @override
  State<ResultTest> createState() => _ResultTestState();
}

// DateFormat('yMd').format(DateTime.now()).toString(),
class _ResultTestState extends State<ResultTest> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference results = FirebaseFirestore.instance.collection('result');
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/Background_tests.png'))),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 100,
                height: 120,
                child: Card(
                  color: TestResultModel.testResult >= 3
                      ? Colors.green
                      : Colors.red,
                  child: Center(
                    child: Text(
                      '${TestResultModel.testResult}',
                      style: const TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
              ),
              const Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[\\.|\\,|\\ |\\!|\\?|\\-|\\a-zA-Z\\а-яА-Я]"))
                    ],
                    enableSuggestions: true, // hints on keyboard
                    enableIMEPersonalizedLearning: true,
                    enableInteractiveSelection: true,
                    toolbarOptions: const ToolbarOptions(
                        copy: true, cut: true, paste: true, selectAll: true),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (String value) {},
                    controller: _textEditingController,
                    keyboardType: TextInputType.name,
                    maxLines: 1,
                    maxLength: 25,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      
                      filled: true,
                      fillColor: Colors.blue.withOpacity(0.3),
                      counterStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: 'Ваш никнейм:',
                      hintStyle:
                          const TextStyle(color: Colors.white60, fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7)),
                      
                    )),
              ),
              CustomButton(
                  text: 'Сохранить результат',
                  method: () {
                    if (TestResultModel.testResult >= 0) {
                      results
                          .add({
                            'name': _textEditingController.text,
                            'score': TestResultModel.testResult,
                            'incorrect': 10 - TestResultModel.testResult
                          })
                          .then((value) {})
                          .catchError((error) => print('Error on push data!'));
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage( )));
                    } else {}
                  }),
              CustomButton(
                  text: 'В меню',
                  method: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage( )));
                  }),
              const SizedBox(
                height: 30,
                
              ),
              CustomButton(
                  text: 'Результаты',
                  method: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PageAllResult()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

