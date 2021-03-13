import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<IpInfoData> fetchIpInfo() async {
  final response = await http.get(Uri.https('ip-addr.shultzlab.com', ''));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return IpInfoData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

String getValue(item){
  if(item == null){
    return 'N/A';
  }
  return item;
}

class IpInfoData {
  final String ip;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String latitude;
  final String longitude;

  IpInfoData({this.ip, this.city, this.state, this.postalCode, this.country, this.latitude, this.longitude});

  factory IpInfoData.fromJson(Map<String, dynamic> json) {
    return IpInfoData(
        ip: getValue(json['ip']),
        city: getValue(json['city']),
        state: getValue(json['state']),
        postalCode: getValue(json['postalCode']),
        country: getValue(json['country']),
        latitude: getValue(json['latitude']),
        longitude: getValue(json['longitude'])
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'ip addr';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title)
        ),
          body: IpInfo()
      ),
    );
  }
}

class IpInfo extends StatefulWidget {
  @override
  _IpInfoState createState() => _IpInfoState();
}

class _IpInfoState extends State<IpInfo> {
  Future<IpInfoData> futureIpInfo;

  @override
  void initState() {
    super.initState();
    futureIpInfo = fetchIpInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<IpInfoData>(
        future: futureIpInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.public_outlined),
                          title: Text('IP Address'),
                          subtitle: Text(snapshot.data.ip),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.public_outlined),
                          title: Text('City'),
                          subtitle: Text(snapshot.data.city),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.public_outlined),
                          title: Text('State'),
                          subtitle: Text(snapshot.data.state),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.public_outlined),
                          title: Text('Postal Code'),
                          subtitle: Text(snapshot.data.postalCode),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.public_outlined),
                          title: Text('Latitude'),
                          subtitle: Text(snapshot.data.latitude),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.public_outlined),
                          title: Text('Longitude'),
                          subtitle: Text(snapshot.data.longitude),
                        )
                      ],
                    ),
                  ),
                ]
              )
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );



  }
}


