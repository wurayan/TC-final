import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:PARTIU/models/eventos.dart';
import 'package:PARTIU/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadEvento(String descricao, 
    Uint8List file, 
    String uid,
    String username, 
    // String profImage
    
    ) async {
        String res = "erro";
    try {
       String photoUrl = await StorageMethods().uploadImageToStorage('eventos', file, true);

      String eventoId = const Uuid().v1(); // creates unique id based on time

      Evento evento = Evento(
        descricao: descricao,
        uid: uid,
        username: username,
        likes: [],
        eventoId: eventoId,
        data: DateTime.now(),
        eventoUrl: photoUrl,
        // profImage: profImage,
      );
      _firestore.collection('eventos').doc(eventoId).set(evento.toJson());
      res = "successo";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String eventoId, String uid, List likes) async {
    String res = "erro";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('eventos').doc(eventoId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('eventos').doc(eventoId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'successo';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  // Future<String> postComment(String eventoId, String text, String uid,
  //     String name, String profilePic) async {
  //   String res = "erro";
  //   try {
  //     if (text.isNotEmpty) {
  //       // if the likes list contains the user uid, we need to remove it
  //       String commentId = const Uuid().v1();
  //       _firestore
  //           .collection('eventos')
  //           .doc(eventoId)
  //           .collection('comments')
  //           .doc(commentId)
  //           .set({
  //         'profilePic': profilePic,
  //         'name': name,
  //         'uid': uid,
  //         'text': text,
  //         'commentId': commentId,
  //         'datePublished': DateTime.now(),
  //       });
  //       res = 'success';
  //     } else {
  //       res = "Please enter text";
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }

  // Delete evento
  Future<String> deleteEvento(String eventoId) async {
    String res = "erro";
    try {
      await _firestore.collection('eventos').doc(eventoId).delete();
      res = 'successo';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> favoritar(
    String uid, //seu id
    String favId // id de quem voce ta favoritando
  ) async {
    try {
      DocumentSnapshot snap = await _firestore
      .collection('users').doc(uid).get(); //pega os seus dados
      List favoritos = (snap.data()! as dynamic)['favoritos']; //pega os favoritos da sua lista

      if(favoritos.contains(favId)) { //se a sua lista tem o id de quem voce ta favoritando
        //remove o id dele da sua lista de favoritos
        await _firestore.collection('users').doc(uid).update({
          'favoritos': FieldValue.arrayRemove([favId])
        });

      } else {
        //adiciona o id dele na sua lsita de favoritos
        await _firestore
        .collection('users').doc(uid).update({
          'favoritos': FieldValue.arrayUnion([favId])
        });
      }

    } catch(e) {
      print(e.toString());
    }
  }
}
