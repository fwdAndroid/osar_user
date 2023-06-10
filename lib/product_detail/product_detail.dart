import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:osar_user/order/order_now.dart';

class ProductDetail extends StatefulWidget {
  final image;
  final prductPrice;
  final productDescription;
  final productImages;
  final productName;
  final productUUid;
  final storeAddress;
  final storeName;
  final storeid;
  ProductDetail(
      {super.key,
      required this.image,
      required this.prductPrice,
      required this.productDescription,
      required this.productImages,
      required this.productName,
      required this.productUUid,
      required this.storeAddress,
      required this.storeName,
      required this.storeid});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Product Detail",
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Image.network(
              widget.image,
              fit: BoxFit.fitWidth,
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Product Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(widget.productName),
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Product Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(widget.productDescription),
          ),
          Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Product Price",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Text(widget.prductPrice.toString()),
          ),
          SizedBox(
            height: 20,
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
                              content: const Text(
                                  'Are You Sure To Order This Product'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (builder) => OrderNow(
                                    //               productUuod:
                                    //                   widget.productUuod,
                                    //               ProductDescritption: widget
                                    //                   .ProductDescritption,
                                    //               ProductImage:
                                    //                   widget.ProductImage,
                                    //               ProductName:
                                    //                   widget.ProductName,
                                    //               ProductPrice:
                                    //                   widget.ProductPrice,
                                    //             )));
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
}
