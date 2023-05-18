// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:instagram/screens/add_post_screen.dart';
// import 'package:instagram/screens/feed_screen.dart';
// import 'package:instagram/screens/profile_screen.dart';
// import 'package:instagram/screens/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:osar_user/bottompages/chat_page.dart';
import 'package:osar_user/bottompages/home_page.dart';
import 'package:osar_user/bottompages/order_page.dart';
import 'package:osar_user/bottompages/setting_page.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  Home(),
  OrderPage(),
  ChatPage(),
  SettingPage(),

  // Profile()
  //  Random(),
  //  ChatPage(),
  //  Profile(),
];
