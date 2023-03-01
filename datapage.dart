import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> mydatalist = [];
  List<String> myimage = [];
  @override
  void initState() {
    fetchdata();
    // TODO: implement initState
    super.initState();
    print(myimage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Main Page"),
          ),
          body: CarouselSlider(
            options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1)),
            items: myimage
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(item, fit: BoxFit.cover),
                      ),
                    ))
                .toList(),
          )),
    );
  }

  fetchdata() async {
    final uri =
        Uri.https('akshusofttech.com', 'philbrick/Philbrick_apis/bannerlist');

    final response = await http.post(uri, headers: {
      'x-api-key': 'ehello',
      'Client-Service': 'secureclient',
      'Auth-key': 'authforall',
      'auth-token': 'MW1LdTZRMFljdWpaYS9XTFZXRTRnZz09'
    });
    Map<String, dynamic> mymap = json.decode(response.body);

    setState(() {
      mydatalist = mymap['data'];
    });
    for (int i = 0; i < mydatalist.length; i++) {
      myimage.add(mydatalist[i]['img_url']);
    }
  }
}
