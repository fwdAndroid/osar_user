import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osar_user/product_detail/product_detail.dart';

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasError)
                          return Text('Error = ${snapshot.error}');
                        if (snapshot.hasData) {
                          final docs = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: docs.length,
                            itemBuilder: (_, i) {
                              final data = docs[i].data();
                              return Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  data['name'],
                                  style: TextStyle(
                                      color: Color(0xff1D1E20),
                                      fontSize: 29,
                                      fontWeight: FontWeight.w800),
                                ),
                              );
                            },
                          );
                        }

                        return Center(child: CircularProgressIndicator());
                      },
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
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                      childAspectRatio: 2 / 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                              itemCount: documents.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final Map<String, dynamic> data =
                                    documents[index].data()
                                        as Map<String, dynamic>;

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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    ProductDetail(
                                                      image: data['image'],
                                                      prductPrice:
                                                          data['prductPrice'],
                                                      productDescription: data[
                                                          'productDescription'],
                                                      productImages:
                                                          data['productImages'],
                                                      productName:
                                                          data['productName'],
                                                      productUUid:
                                                          data['productUUid'],
                                                      storeAddress:
                                                          data['storeAddress'],
                                                      storeName:
                                                          data['storeName'],
                                                      storeid: data['storeid'],
                                                    )));
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
      ),
    );
  }
}
