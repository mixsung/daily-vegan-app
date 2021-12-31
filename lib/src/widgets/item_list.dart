import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_vegan_app/src/screens/edit_screen.dart';
import 'package:daily_vegan_app/src/screens/specific_screen.dart';
import 'package:daily_vegan_app/src/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.data?.docs.length == 0) {
          return Center(
              child: Text('아직 게시물이 없습니다.',
                  style: TextStyle(
                      fontFamily: 'NotoSerifKR',
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0)));
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data!.docs[index].data()!;
              String docID = snapshot.data!.docs[index].id;
              String name = (noteInfo as dynamic)['name'];
              String recipe = (noteInfo as dynamic)['recipe'];
              String date = (noteInfo as dynamic)['date'];
              String photo = (noteInfo as dynamic)['photoUrl'].toString();

              User? user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                return Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('로그인을 해주세요.',
                          style: TextStyle(
                              fontFamily: 'NotoSerifKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0)),
                    ));
              }
              return Ink(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black)),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                      // 수정 중
                      MaterialPageRoute(
                          builder: (context) => SpecificScreen(
                                currentName: name,
                                currentRecipe: recipe,
                                documentId: docID,
                                docDate: date,
                                photoUrl: photo,
                              ))
                      // MaterialPageRoute(
                      //   builder: (context) => EditScreen(
                      //     currentName: name,
                      //     currentRecipe: recipe,
                      //     documentId: docID,
                      //   ),
                      // ),
                      ),
                  leading: Image.network(photo),
                  title: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'NotoSerifKR',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0),
                  ),
                  subtitle: Text(
                    recipe,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'NotoSerifKR',
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        );
      },
    );
  }
}
