import 'package:cloud_firestore/cloud_firestore.dart';

class Evento {
  final String descricao;
  final String uid;
  final String username;
  final likes;
  final String eventoId;
  final DateTime data;
  final String eventoUrl;
  // final String profImage;

  const Evento(
      {required this.descricao,
      required this.uid,
      required this.username,
      required this.likes,
      required this.eventoId,
      required this.data,
      required this.eventoUrl,
      // required this.profImage,
      });

  static Evento fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Evento(
      descricao: snapshot["descricao"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      eventoId: snapshot["eventoId"],
      data: snapshot["data"],
      username: snapshot["username"],
      eventoUrl: snapshot['eventoUrl'],
      // profImage: snapshot['profImage']
    );
  }

   Map<String, dynamic> toJson() => {
        "descricao": descricao,
        "uid": uid,
        "likes": likes,
        "username": username,
        "eventoId": eventoId,
        "data": data,
        'eventoUrl': eventoUrl,
        // 'profImage': profImage
      };
}
