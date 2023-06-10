import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osar_user/user_main_dashboard.dart';
import 'package:uuid/uuid.dart';

class ProceedOrder extends StatefulWidget {
  final image;
  final prductPrice;
  final productDescription;
  final productImages;
  final productName;
  final productUUid;
  final storeAddress;
  final storeName;
  final storeid;
  final Quantity;
  final Location;
  const ProceedOrder({
    super.key,
    required this.image,
    required this.prductPrice,
    required this.productImages,
    required this.productDescription,
    required this.storeAddress,
    required this.storeName,
    required this.storeid,
    required this.productName,
    required this.productUUid,
    required this.Location,
    required this.Quantity,
  });

  @override
  State<ProceedOrder> createState() => _ProceedOrderState();
}

class _ProceedOrderState extends State<ProceedOrder> {
  var uui = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.productName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffFFBF00), shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Product Name",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.productName),
                    Divider(),
                    Text(
                      "Product Description",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.productDescription),
                    Divider(),
                    Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.Location),
                    Divider(),
                    Text(
                      "Product Quantity",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.Quantity.toString()),
                    Divider(),
                    Text(
                      "Total Product Price",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(prices(int.parse(widget.Quantity), widget.prductPrice)
                        .toString()),
                    // Divider(),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    fixedSize: Size(260, 50),
                    backgroundColor: Color(0xffFFBF00)),
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text('Order Alert'),
                              content:
                                  const Text('Do You want to Confrim Order'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection("orders")
                                        .doc(uui)
                                        .set({
                                      "orderstatus": "initialized",
                                      "productDescription":
                                          widget.productDescription,
                                      "uid": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "storeName": widget.storeName,
                                      "storeaddress": widget.storeAddress,
                                      "storeid": widget.storeid,
                                      "productName": widget.productName,
                                      "productPrice": prices(
                                          int.parse(widget.Quantity),
                                          widget.prductPrice),
                                      "productQuantity":
                                          int.parse(widget.Quantity),
                                      "Location": widget.Location,
                                      "productImage": widget.image,
                                      "productId": widget.productUUid,
                                      "confrimOrderId": uui
                                    }).then((value) => {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Order is Placed Successfully"),
                                                ),
                                              ),
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          UserMainDashBoard()))
                                            });
                                  },
                                  child: const Text('OK'),
                                ),
                              ]));
                },
                child: Text(
                  "Order Now",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  prices(int i, int b) {
    return i * b;
  }
}
