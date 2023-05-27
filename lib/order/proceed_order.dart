import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osar_user/order/order_now.dart';
import 'package:osar_user/user_main_dashboard.dart';
import 'package:uuid/uuid.dart';

class ProceedOrder extends StatefulWidget {
  final ProductName;
  final ProductDescritption;
  final ProductImage;
  final ProductPrice;
  final Quantity;
  final Location;
  final productUuod;
  const ProceedOrder(
      {super.key,
      required this.productUuod,
      required this.ProductDescritption,
      required this.ProductImage,
      required this.ProductName,
      required this.Location,
      required this.Quantity,
      required this.ProductPrice});

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
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => OrderNow(
                            productUuod: widget.productUuod,
                            ProductDescritption: widget.ProductDescritption,
                            ProductImage: widget.ProductImage,
                            ProductName: widget.ProductName,
                            ProductPrice: widget.ProductPrice)));
              },
              child: Text("Edit Order"))
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.ProductName,
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
                    Text(widget.ProductName),
                    Divider(),
                    Text(
                      "Product Description",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.ProductDescritption),
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
                    Text(prices(int.parse(widget.Quantity), widget.ProductPrice)
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
                                      "uid": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "ProductPrice": prices(
                                          int.parse(widget.Quantity),
                                          widget.ProductPrice),
                                      "ProductQuantity":
                                          int.parse(widget.Quantity),
                                      "Location": widget.Location,
                                      "ProductImage": widget.ProductImage,
                                      "ProductId": widget.productUuod,
                                      "ConfrimOrderId": uui
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
