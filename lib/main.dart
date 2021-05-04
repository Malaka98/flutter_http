import 'dart:async';
import 'dart:collection';
import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse('https://roootx.codes'));

  // Use the compute function to run parsePhotos in a separate isolate.
  // print(response.body);
  // return compute(parsePhotos, response.body);
  return response.body;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var d = [];
  Future<void> getdata() async {
    var data = await fetchPhotos(http.Client());
    Map<String, dynamic> x = jsonDecode(data);
    List fd = [];
    x.forEach((key, value) {
      fd.add(value);
    });
    // print(fd);
    var sd = fd.where((element) => element['m'] == '1').toList();
    // print(sd);
    setState(() {
      d = sd;
    });
    // print(d.keys.toList());
    // List<String> iotdata = [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get data"),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: d.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Temp: ${d[index]['temp'].toString()}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "Humidity: ${d[index]['h'].toString()}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "Motion: ${d[index]['m'].toString()}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ));
            },
          ),
        ));
  }
}
