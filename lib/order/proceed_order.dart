import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
