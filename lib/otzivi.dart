import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller.dart';

class PageOtzivi extends StatelessWidget {
  String? NewOtziv;

  Widget _buildName({String? imageAsset, String? name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          Container(height: 2, color: const Color.fromRGBO(179, 103, 181, 1)),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(imageAsset!),
                radius: 25,
              ),
              const SizedBox(width: 12),
              Text(name!),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('otzivi').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const Text('Нет записей');
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  return _buildName(
                      imageAsset: 'images/polzovatel.png',
                      name: snapshot.data!.docs[index].get('otziv'));
                });
          },
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
          child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Оставить отзыв'),
                        content: TextField(
                          maxLength: 25,
                          inputFormatters: [
                               FilteringTextInputFormatter.deny(RegExp("[\\.|\\,|\\ |\\!|\\?|\\-|\\a-zA-Z\\а-яА-Я]")),
                          ],
                          onChanged: (String value) {
                            NewOtziv = value;
                            
                          },
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                if (NewOtziv != null) {
                                  FirebaseFirestore.instance
                                      .collection('otzivi')
                                      .add({'otziv': NewOtziv});
                                      NewOtziv = null;
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          elevation: 3,
                                          backgroundColor: const Color.fromRGBO(
                                              211, 211, 211, 0.6),
                                          child: Container(
                                              height: 80,
                                              alignment:
                                                  AlignmentDirectional.center,
                                              padding: const EdgeInsets.all(15),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: const Text(
                                                  'Нельзя оставить пустой комментарий!',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )),
                                        );
                                      });
                                }
                              },
                              child: const Text('Отправить'))
                        ],
                      );
                    });
              },
                child: Image(
                 image: AssetImage('images/ostavitotziv.png'),
                 width: 75,
               ),
              ),
        )
      ],
    ));
  }
}
