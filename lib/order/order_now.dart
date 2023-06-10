import 'package:flutter/material.dart';
import 'package:osar_user/order/proceed_order.dart';
import 'package:osar_user/widgets/textfieldwidget.dart';

class OrderNow extends StatefulWidget {
  final image;
  final prductPrice;
  final productDescription;
  final productImages;
  final productName;
  final productUUid;
  final storeAddress;
  final storeName;
  final storeid;
  OrderNow({
    super.key,
    required this.prductPrice,
    required this.productDescription,
    required this.productImages,
    required this.image,
    required this.storeAddress,
    required this.productName,
    required this.productUUid,
    required this.storeName,
    required this.storeid,
  });

  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    widget.image,
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
                      Text(widget.productName),
                      Divider(
                        color: Colors.red,
                      ),
                      Text(
                        "Product Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.productDescription),
                      Divider(),
                      Text(
                        "Product Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.prductPrice.toString())
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextFormInputField(
                hintText: 'User Name',
                textInputType: TextInputType.text,
                controller: _username,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
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
                controller: _quantityController,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: TextFormInputField(
                hintText: 'Phone Number',
                textInputType: TextInputType.number,
                controller: _phoneNumber,
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
                                      if (_locationController.text.isEmpty ||
                                          _quantityController.text.isEmpty ||
                                          _username.text.isEmpty ||
                                          _phoneNumber.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "All fields is Required is required")));
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    ProceedOrder(
                                                      username: _username.text,
                                                      phoneNumber:
                                                          _phoneNumber.text,
                                                      storeid: widget.storeid,
                                                      storeName:
                                                          widget.storeName,
                                                      storeAddress:
                                                          widget.storeAddress,
                                                      productImages:
                                                          widget.productImages,
                                                      Location:
                                                          _locationController
                                                              .text,
                                                      Quantity:
                                                          _quantityController
                                                              .text,
                                                      productUUid:
                                                          widget.productUUid,
                                                      productDescription: widget
                                                          .productDescription,
                                                      image: widget.image,
                                                      productName:
                                                          widget.productName,
                                                      prductPrice:
                                                          widget.prductPrice,
                                                    )));
                                      }
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
