import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  final storeName, storeId, username, uid;
  ChatRoom(
      {super.key,
      required this.storeId,
      required this.storeName,
      required this.uid,
      required this.username});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String groupChatId = "";
  ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  UploadTask? task;
  File? file;
  bool show = false;
  String? imageLink, fileLink;

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (FirebaseAuth.instance.currentUser!.uid.hashCode <=
        widget.storeId.hashCode) {
      groupChatId =
          "${FirebaseAuth.instance.currentUser!.uid}-${widget.storeId}";
    } else {
      groupChatId =
          "${widget.storeId}-${FirebaseAuth.instance.currentUser!.uid}";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text(
                widget.storeName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.username,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WillPopScope(
            onWillPop: () {
              if (show) {
                setState(() {
                  show = false;
                });
              } else {
                Navigator.pop(context);
              }
              return Future.value(false);
            },
            child: Column(
              children: <Widget>[
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("messages")
                        .doc(groupChatId)
                        .collection(groupChatId)
                        .orderBy("timestamp", descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.docs == 0
                            ? Center(child: Text("Empty "))
                            : Expanded(
                                child: ListView.builder(
                                  reverse: false,
                                  controller: scrollController,
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  itemBuilder: (context, index) {
                                    var ds = snapshot.data!.docs[index];
                                    return ds.get("type") == 0
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Align(
                                              alignment: (ds.get("senderId") ==
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                  ? Alignment.bottomRight
                                                  : Alignment.bottomLeft),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: (ds.get("senderId") ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid
                                                      ? Colors.grey.shade100
                                                      : Colors.blue[100]),
                                                ),
                                                padding: EdgeInsets.all(16),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      ds.get("content"),
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      DateFormat.jm().format(DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                              int.parse(ds.get(
                                                                  "time")))),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : ds.get("type") == 1
                                            ? Stack(
                                                children: [
                                                  InkWell(
                                                    child: Column(children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 10,
                                                                bottom: 10),
                                                        child: Align(
                                                          alignment: (ds.get(
                                                                      "senderId") ==
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid
                                                              ? Alignment
                                                                  .bottomRight
                                                              : Alignment
                                                                  .bottomLeft),
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),

                                                              // color: (ds.get("senderId") == FirebaseAuth.instance.currentUser!.uid?Colors.grey.shade100:Colors.blue[100]),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 140,
                                                                  imageUrl: ds.get(
                                                                      "image"),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      new CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      new Icon(Icons
                                                                          .error),
                                                                ),
                                                                Text(
                                                                  DateFormat
                                                                          .jm()
                                                                      .format(DateTime
                                                                          .fromMillisecondsSinceEpoch(
                                                                              int.parse(ds.get("time")))),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          12,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic),
                                                                ),
                                                              ],
                                                            ),
                                                            // padding: EdgeInsets.all(16),
                                                          ),
                                                        ),
                                                      ),
                                                      task != null
                                                          ? buildUploadStatus(
                                                              task!)
                                                          : Container(),
                                                    ]),
                                                  ),
                                                ],
                                              )
                                            : Container();
                                  },
                                ),
                              );
                      } else if (snapshot.hasError) {
                        return Center(child: Icon(Icons.error_outline));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) => SafeArea(
                                child: SizedBox(
                                  height: 144,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          addImage();
                                        },
                                        child: const Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text('Photo'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            sendMessage(messageController.text.trim(), 0);
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  //Functions

  void sendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      messageController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": FirebaseAuth.instance.currentUser!.uid,
            "receiverId": widget.storeId,
            "time": DateTime.now().millisecondsSinceEpoch.toString(),
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      // Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            );
          } else {
            return Container();
          }
        },
      );

  Future uploadImageToFirebase() async {
    File? fileName = imageUrl;
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(
            'messages/${FirebaseAuth.instance.currentUser!.uid}/images+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(fileName!);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() async {
      print(fileName);
      String img = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        imageLink = img;
      });
    });
  }

  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
    await uploadImageToFirebase().then((value) {
      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            "senderId": FirebaseAuth.instance.currentUser!.uid,
            "receiverId": widget.storeId,
            // "content": messageController.text,
            "time": DateTime.now().millisecondsSinceEpoch.toString(),
            'image': imageLink,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            // 'content': content,
            "file": "",
            'type': 1,
          },
        );
      });
    }).then((value) {
      // FocusScope.of(context).unfocus();
      messageController.clear();
    });
  }
}
