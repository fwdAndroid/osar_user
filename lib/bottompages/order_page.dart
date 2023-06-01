import 'package:flutter/material.dart';
import 'package:osar_user/tab/current_orders.dart';
import 'package:osar_user/tab/past_orders.dart';

/// Flutter code sample for [TabBar].

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Current Orders",
            ),
            Tab(
              text: "Past Orders",
            ),
          ],
          labelColor: Colors.black,
          dividerColor: Colors.yellow,
          indicatorColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[CurrentOrders(), PastOrders()],
      ),
    );
  }
}
