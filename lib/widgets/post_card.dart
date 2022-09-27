import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:PARTIU/models/user.dart' as model;
import 'package:PARTIU/providers/user_provider.dart';
import 'package:PARTIU/resources/firestore_methods.dart';
import 'package:PARTIU/screens/comments_screen.dart';
import 'package:PARTIU/utils/colors.dart';
import 'package:PARTIU/utils/global_variable.dart';
import 'package:PARTIU/utils/utils.dart';
import 'package:PARTIU/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    // fetchCommentLen();
  }

  // fetchCommentLen() async {
  //   try {
  //     QuerySnapshot snap = await FirebaseFirestore.instance
  //         .collection('eventos')
  //         .doc(widget.snap['eventoId'])
  //         .collection('comments')
  //         .get();
  //     commentLen = snap.docs.length;
  //   } catch (err) {
  //     showSnackBar(
  //       context,
  //       err.toString(),
  //     );
  //   }
  //   setState(() {});
  // }

  deleteEvento(String eventoId) async {
    try {
      await FireStoreMethods().deleteEvento(eventoId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    int like = 0;

    return Container(
      // boundary needed for web
      decoration: BoxDecoration(
        border: Border.all(
          color: width > webScreenSize ? secondaryColor : mobileBackgroundColor,
        ),
        color: mobileBackgroundColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                // widget.snap['uid'].toString() == user.uid?

                // : Container(),
              ],
            ),
          ),
          // IMAGE SECTION OF THE POST
          GestureDetector(
            onDoubleTap: () {
              FireStoreMethods().likePost(
                widget.snap['eventoId'].toString(),
                user.uid,
                widget.snap['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1664138218128-2dcf791a9d27?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                              fit: BoxFit.cover)),
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 7, top: 7),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        'https://images.unsplash.com/photo-1663963860211-646b2241376b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                                  ),
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 8,
                                    ),
                                    child: Text(
                                      'Dona maria',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      useRootNavigator: false,
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            child: ListView(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                shrinkWrap: true,
                                                children: const [
                                              Text('Apagar'),
                                            ]));
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.more_vert),
                                )
                              ]),
                          Expanded(child: Container()),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/postcard.png')
                                    //  AssetImage('assets/postcard.png'),
                                    ,
                                    fit: BoxFit.fill)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo[400],
                                      radius: 30,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Text("8",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    height: 1,
                                                    color: Colors.white)),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.white,
                                              height: 1,
                                            ),
                                            Text("OUT",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    height: 1,
                                                    color: Colors.white))
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.pin_drop,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      " Restaurante da Maria",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "Dia do guioza no restauranete da Dona Maria!!!",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                // Row(
                                //   children: const [
                                //     Text(
                                //       "DATA:",
                                //       style: TextStyle(
                                //           color: secondaryColor, fontSize: 16),
                                //     ),
                                //     Text(
                                //       " 12 de Outubro de 2022",
                                //       style: TextStyle(
                                //           color: secondaryColor, fontSize: 18),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  // AnimatedOpacity(
                  //   duration: const Duration(milliseconds: 200),
                  //   opacity: isLikeAnimating ? 1 : 0,
                  //   child: LikeAnimation(
                  //     isAnimating: isLikeAnimating,
                  //     child: const Icon(
                  //       Icons.favorite,
                  //       color: Colors.white,
                  //       size: 100,
                  //     ),
                  //     duration: const Duration(
                  //       milliseconds: 400,
                  //     ),
                  //     onEnd: () {
                  //       setState(() {
                  //         isLikeAnimating = false;
                  //       });
                  //     },
                  //   ),
                  // ),
                  Row(
                    children: <Widget>[
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: IconButton(
                          icon: widget.snap['likes'].contains(user.uid)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                ),
                          onPressed: () => FireStoreMethods().likePost(
                            widget.snap['eventoId'].toString(),
                            user.uid,
                            widget.snap['likes'],
                          ),
                        ),
                      ),
                      DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.w800),
                          child: Text(
                            '${like} likes',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            icon: const Icon(Icons.send), onPressed: () {}),
                      ))
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.indigo[400],
                    height: 3,
                  ),

                  Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/show.png'),
                              fit: BoxFit.cover)),
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 7, top: 7),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage('assets/euphoria.png')
                                  ),
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 8,
                                    ),
                                    child: Text(
                                      'Euphoria',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      useRootNavigator: false,
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            child: ListView(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                shrinkWrap: true,
                                                children: const [
                                              Text('Apagar'),
                                            ]));
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.more_vert),
                                )
                              ]),
                          Expanded(child: Container()),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/postcard.png')
                                    //  AssetImage('assets/postcard.png'),
                                    ,
                                    fit: BoxFit.fill)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo[400],
                                      radius: 30,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Text("1",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                            Divider(
                                              thickness: 1,
                                              color: Colors.white,
                                              height: 3,
                                            ),
                                            Text("OUT",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.white))
                                          ]),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.pin_drop,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      " Euphoria - R. Laranjeiras, 1348",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      "Show do Luan Pereira",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                // Row(
                                //   children: const [
                                //     Text(
                                //       "DATA:",
                                //       style: TextStyle(
                                //           color: secondaryColor, fontSize: 16),
                                //     ),
                                //     Text(
                                //       " 12 de Outubro de 2022",
                                //       style: TextStyle(
                                //           color: secondaryColor, fontSize: 18),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  // AnimatedOpacity(
                  //   duration: const Duration(milliseconds: 200),
                  //   opacity: isLikeAnimating ? 1 : 0,
                  //   child: LikeAnimation(
                  //     isAnimating: isLikeAnimating,
                  //     child: const Icon(
                  //       Icons.favorite,
                  //       color: Colors.white,
                  //       size: 100,
                  //     ),
                  //     duration: const Duration(
                  //       milliseconds: 400,
                  //     ),
                  //     onEnd: () {
                  //       setState(() {
                  //         isLikeAnimating = false;
                  //       });
                  //     },
                  //   ),
                  // ),
                  Row(
                    children: <Widget>[
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: IconButton(
                          icon: widget.snap['likes'].contains(user.uid)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                ),
                          onPressed: () => FireStoreMethods().likePost(
                            widget.snap['eventoId'].toString(),
                            user.uid,
                            widget.snap['likes'],
                          ),
                        ),
                      ),
                      DefaultTextStyle(
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(fontWeight: FontWeight.w800),
                          child: Text(
                            '${like} likes',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                      Expanded(
                          child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            icon: const Icon(Icons.send), onPressed: () {}),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          // LIKE, COMMENT SECTION OF THE POST
        ],
      ),
    );
  }
}


//  return Container(
//       // boundary needed for web
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: width > webScreenSize 
//           ? secondaryColor : mobileBackgroundColor,
//         ),
//         color: mobileBackgroundColor,
//       ),
//       padding: const EdgeInsets.symmetric(
//         vertical: 10,
//       ),
//       child: Column(
//         children: [
//           // HEADER SECTION OF THE POST
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 4,
//               horizontal: 16,
//             ).copyWith(right: 0),
//             child: Row(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundImage: NetworkImage(
//                     widget.snap['profImage'].toString(),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       left: 8,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           widget.snap['username'].toString(),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 widget.snap['uid'].toString() == user.uid
//                     ? IconButton(
//                         onPressed: () {
//                           showDialog(
//                             useRootNavigator: false,
//                             context: context,
//                             builder: (context) {
//                               return Dialog(
//                                 child: ListView(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 16),
//                                     shrinkWrap: true,
//                                     children: [
//                                       'Apagar',
//                                     ]
//                                         .map(
//                                           (e) => InkWell(
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 12,
//                                                         horizontal: 16),
//                                                 child: Text(e),
//                                               ),
//                                               onTap: () {
//                                                 deleteEvento(
//                                                   widget.snap['eventoId']
//                                                       .toString(),
//                                                 );
//                                                 // remove the dialog box
//                                                 Navigator.of(context).pop();
//                                               }),
//                                         )
//                                         .toList()),
//                               );
//                             },
//                           );
//                         },
//                         icon: const Icon(Icons.more_vert),
//                       )
//                     : Container(),
//               ],
//             ),
//           ),
//           // IMAGE SECTION OF THE POST
//           GestureDetector(
//             onDoubleTap: () {
//               FireStoreMethods().likePost(
//                 widget.snap['eventoId'].toString(),
//                 user.uid,
//                 widget.snap['likes'],
//               );
//               setState(() {
//                 isLikeAnimating = true;
//               });
//             },
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.35,
//                   width: double.infinity,
//                   child: Image.network(
//                     widget.snap['postUrl'].toString(),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 AnimatedOpacity(
//                   duration: const Duration(milliseconds: 200),
//                   opacity: isLikeAnimating ? 1 : 0,
//                   child: LikeAnimation(
//                     isAnimating: isLikeAnimating,
//                     child: const Icon(
//                       Icons.favorite,
//                       color: Colors.white,
//                       size: 100,
//                     ),
//                     duration: const Duration(
//                       milliseconds: 400,
//                     ),
//                     onEnd: () {
//                       setState(() {
//                         isLikeAnimating = false;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // LIKE, COMMENT SECTION OF THE POST
//           Row(
//             children: <Widget>[
//               LikeAnimation(
//                 isAnimating: widget.snap['likes'].contains(user.uid),
//                 smallLike: true,
//                 child: IconButton(
//                   icon: widget.snap['likes'].contains(user.uid)
//                       ? const Icon(
//                           Icons.favorite,
//                           color: Colors.red,
//                         )
//                       : const Icon(
//                           Icons.favorite_border,
//                         ),
//                   onPressed: () => FireStoreMethods().likePost(
//                     widget.snap['eventoId'].toString(),
//                     user.uid,
//                     widget.snap['likes'],
//                   ),
//                 ),
//               ),
//               // IconButton(
//               //   icon: const Icon(
//               //     Icons.comment_outlined,
//               //   ),
//               //   onPressed: () => Navigator.of(context).push(
//               //     MaterialPageRoute(
//               //       builder: (context) => CommentsScreen(
//               //         eventoId: widget.snap['eventoId'].toString(),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               IconButton(
//                   icon: const Icon(
//                     Icons.send,
//                   ),
//                   onPressed: () {}),
//               Expanded(
//                   child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: IconButton(
//                     icon: const Icon(Icons.bookmark_border), onPressed: () {}),
//               ))
//             ],
//           ),
//           //DESCRIPTION AND NUMBER OF COMMENTS
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 DefaultTextStyle(
//                     style: Theme.of(context)
//                         .textTheme
//                         .subtitle2!
//                         .copyWith(fontWeight: FontWeight.w800),
//                     child: Text(
//                       '${widget.snap['likes'].length} likes',
//                       style: Theme.of(context).textTheme.bodyText2,
//                     )),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.only(
//                     top: 8,
//                   ),
//                   child: RichText(
//                     text: TextSpan(
//                       style: const TextStyle(color: primaryColor),
//                       children: [
//                         TextSpan(
//                           text: widget.snap['username'].toString(),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(
//                           text: ' ${widget.snap['descricao']}',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // InkWell(
//                 //   child: Container(
//                 //     child: Text(
//                 //       'View all $commentLen comments',
//                 //       style: const TextStyle(
//                 //         fontSize: 16,
//                 //         color: secondaryColor,
//                 //       ),
//                 //     ),
//                 //     padding: const EdgeInsets.symmetric(vertical: 4),
//                 //   ),
//                 //   onTap: () => Navigator.of(context).push(
//                 //     MaterialPageRoute(
//                 //       builder: (context) => CommentsScreen(
//                 //         eventoId: widget.snap['eventoId'].toString(),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 Container(
//                   child: Text(
//                     DateFormat.yMMMd()
//                         .format(widget.snap['data'].toDate()),
//                     style: const TextStyle(
//                       color: secondaryColor,
//                     ),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }