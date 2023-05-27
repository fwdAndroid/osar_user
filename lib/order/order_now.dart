import 'package:flutter/material.dart';
import 'package:osar_user/order/proceed_order.dart';
import 'package:osar_user/widgets/textfieldwidget.dart';

class OrderNow extends StatefulWidget {
  final ProductName;
  final ProductDescritption;
  final ProductImage;
  final ProductPrice;
  final productUuod;
  OrderNow(
      {super.key,
      required this.productUuod,
      required this.ProductDescritption,
      required this.ProductImage,
      required this.ProductName,
      required this.ProductPrice});

  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    widget.ProductImage,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      Text(
                        "Product Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.ProductName),
                      Divider(
                        color: Colors.red,
                      ),
                      Text(
                        "Product Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.ProductDescritption),
                      Divider(),
                      Text(
                        "Product Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.ProductPrice.toString())
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'Location',
                textInputType: TextInputType.text,
                controller: _locationController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: TextFormInputField(
                hintText: 'Quantity',
                textInputType: TextInputType.number,
                controller: _locationController,
              ),
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
                                content:
                                    const Text('Are You Sure Proceed Order'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  ProceedOrder(
                                                    Location:
                                                        _locationController
                                                            .text,
                                                    Quantity: int.parse(
                                                        _quantityController
                                                            .text),
                                                    productUuod:
                                                        widget.productUuod,
                                                    ProductDescritption: widget
                                                        .ProductDescritption,
                                                    ProductImage:
                                                        widget.ProductImage,
                                                    ProductName:
                                                        widget.ProductName,
                                                    ProductPrice:
                                                        widget.ProductPrice,
                                                  )));
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
      ),
    );
  }
}
