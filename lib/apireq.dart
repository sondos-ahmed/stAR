import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APOD extends StatefulWidget {
  const APOD({super.key});

  State<APOD> createState() => _APODState();
}

class _APODState extends State<APOD> {
  Map<String, dynamic>? starData;

  @override
  void initState() {
    super.initState();
    _fetchAPI();
  }

  @override
  Widget build(BuildContext context) {
    var body;
    if (starData != null) {
      body = SingleChildScrollView(
        child: Center(
            child: Column(children: [
          Container(
              margin: EdgeInsets.all(5),
              child: Image.network(starData!['hdurl'])),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text(
              "Image Owned By:",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Text(starData!['copyright'],
              style: TextStyle(fontSize: 12, color: Colors.amber)),
          Row(children: const [Text(""), Spacer(), Text("")]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              starData!['title'],
              style: TextStyle(fontSize: 25, fontFamily: "MartianMono"),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              width: 375,
              child: Text(starData!['explanation'],
                  style: TextStyle(fontSize: 15)))
        ])),
      );
    } else {
      body = Center(
          child: Column(
        children: [
          Text(
              'Hey there Space Cadet, would you like to view an amazing astronomical picture from NASA everyday? You would! Well then click the button!'),
          ElevatedButton(
            onPressed: _fetchAPI,
            child: Text("Get Awesome Stuff"),
          )
        ],
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.cover,
          child: const Text('Astronomy Picture Of The Day',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "MartianMono",
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      body: body,
    );
  }

  _fetchAPI() async {
    const url =
        'https://api.nasa.gov/planetary/apod?api_key=iRDlURIVK0SQdDk3D5Wx1Rd1Tr9J4zP5YHSWWP91';
    var uri = Uri.parse(url);
    var res = await http.get(uri);
    var body = res.body;
    var copy = jsonDecode(body);
    setState(() {
      starData = Map.from(copy);
    });
    print('SUCCESSSSSS!!!!');
  }
}
