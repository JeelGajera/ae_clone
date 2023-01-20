// import 'package:ae_clone/views/evntlist_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Event App",
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      // home: EventList(type: "music", link: "https://allevents.s3.amazonaws.com/tests/music.json", transition: Transition.zoom),
    );
  }
}