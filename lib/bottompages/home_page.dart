import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:osar_user/widgets/my_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "Hemendra",
                    style: TextStyle(
                        color: Color(0xff1D1E20),
                        fontSize: 29,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  "    Welcome to Osar Users.",
                  style: TextStyle(
                      color: Color(0xff8F959E),
                      fontSize: 15,
                      fontWeight: FontWeight.w800),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: CupertinoSearchTextField(
                      controller: _controller,
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                      autocorrect: true,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("productlist")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;

                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemCount: documents.length,
                            itemBuilder: (BuildContext ctx, index) {
                              final Map<String, dynamic> data = documents[index]
                                  .data() as Map<String, dynamic>;

                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 340,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (builder) =>
                                      //             ProductDetail(
                                      //               productUuod:
                                      //                   data['productUUid'],
                                      //               ProductDescritption: data[
                                      //                   'productDescription'],
                                      //               ProductImage: data['image'],
                                      //               ProductName:
                                      //                   data['productName'],
                                      //               ProductPrice:
                                      //                   data['prductPrice'],
                                      //             )));
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            data["image"],
                                            height: 78,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Product Name",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              data['productName'],
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
