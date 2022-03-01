// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PageAllResult extends StatelessWidget {
  const PageAllResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> results  = FirebaseFirestore.instance
        .collection('result')
        .orderBy('score', descending: true) // from the biggest to lower.
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        excludeHeaderSemantics: true,
        title: const Text('Рекорды:'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Image(image: AssetImage('images/Background_tests.png'), fit: BoxFit.cover,),
            StreamBuilder(
            stream: results,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              final data = snapshot.requireData;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Подгружаю');
              }
              if (snapshot.hasError) {
                return const Text('Ошибка загрузки');
              }
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text('Загружаю'),
                    CircularProgressIndicator()
                  ],
                );
              } else {
                return Stack(
                  children: [
                    ListView.builder(
                    itemCount: data.size,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Row(
                          
                          children: [
                          Image(image: AssetImage('images/polzovatel.png'), width: 50),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0)),
                          Text(data.docs[index]['score'].toString(), style: TextStyle(color: Colors.white, fontSize: 20)),
                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 40, 0)),
                          Text(data.docs[index]['name'], style: TextStyle(color: Colors.white, fontSize: 20)),
                          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                              ],
                            ),
                          );
                    })
                  ],
                );
              }
            }),
          ],
        )
      ),
    );
  }
}