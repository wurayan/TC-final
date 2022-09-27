import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:PARTIU/providers/user_provider.dart';
import 'package:PARTIU/resources/firestore_methods.dart';
import 'package:PARTIU/utils/colors.dart';
import 'package:PARTIU/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventoScreen extends StatefulWidget {
  const AddEventoScreen({Key? key}) : super(key: key);

  @override
  _AddEventoScreenState createState() => _AddEventoScreenState();
}

class _AddEventoScreenState extends State<AddEventoScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Criar evento'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Tire uma foto'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Escolha da galeria'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, 
  // String profImage
  ) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadEvento(
        _descriptionController.text,
        _file!,
        uid,
        username,
        // profImage,
      );
      if (res == "successo") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Criado!',
        );
        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final UserProvider userProvider = Provider
    // .of<UserProvider>(context);
    DateTime agora = DateTime.now();
    String data = DateFormat('d MMM').format(agora);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Criar evento"),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {}, 
          child: const Text("Post",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16.0)))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/ray.png'),
                ),
                const Text(" Rayan Wu")
              ]
            ),
            SizedBox(height: 15,),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/rpg.png'),
                fit: BoxFit.cover)
              ),
              child: Column(
                children:[
                  Expanded(child: Container(),),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/postcard.png'),
                      fit: BoxFit.fill)
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          Text(data, style: TextStyle(
                            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600
                          )),
                          SizedBox(height: 20,),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _localController,
                            decoration: InputDecoration(
                                isDense: true,
                                labelText: "Localização",
                                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,width:2),
                                  borderRadius: BorderRadius.all(Radius.circular(20)) 
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,width:1),
                                  borderRadius: BorderRadius.all(Radius.circular(20)) 
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                                ),
                            maxLines: 1,
                          ),
                          SizedBox(height: 10,),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              isDense: true,
                                labelText: "  Escreva uma descrição",
                                labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                                 enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,width:2),
                                  borderRadius: BorderRadius.all(Radius.circular(20)) 
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black,width:1),
                                  borderRadius: BorderRadius.all(Radius.circular(20)) 
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                                ),
                            maxLines: 3,
                          ),
                        ]
                      )
                  ),
                    )
                ]

              ),
            )
          ]

        ),
      )
      
    );
    
  }
}
//  _file == null
//          ? Center(
//              child: IconButton(
//                icon: const Icon(
//                  Icons.upload,
//                ),
//                onPressed: () => _selectImage(context),
//              ),
//            )
//          : 
//         Scaffold(
//             appBar: AppBar(
//               backgroundColor: mobileBackgroundColor,
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: clearImage,
//               ),
//               title: const Text(
//                 'Criar evento',
//               ),
//               centerTitle: false,
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: 
//                   () => postImage(
//                     userProvider.getUser.uid,
//                     userProvider.getUser.username,
//                     // userProvider.getUser.photoUrl,
//                   ),
//                   child: const Text(
//                     "Post",
//                     style: TextStyle(
//                         color: Colors.blueAccent,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0),
//                   ),
//                 )
//               ],
//             ),
//             // POST FORM
//             body: Column(
//               children: <Widget>[
//                 isLoading
//                     ? const LinearProgressIndicator()
//                     : const Padding(padding: EdgeInsets.only(top: 0.0)),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     CircleAvatar(
//                       // backgroundImage: NetworkImage(
//                       //   userProvider.getUser.photoUrl,
//                       // ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context)
//                       .size.width * 0.3,
//                       child: TextField(
//                         controller: _descriptionController,
//                         decoration: const InputDecoration(
//                             hintText: "Escreva uma descrição",
//                             border: InputBorder.none),
//                         maxLines: 8,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 45.0,
//                       width: 45.0,
//                       child: AspectRatio(
//                         aspectRatio: 487 / 451,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                             fit: BoxFit.fill,
//                             alignment: FractionalOffset.topCenter,
//                             image: MemoryImage(_file!),
//                           )),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(),
//               ],
//             ),
//           );