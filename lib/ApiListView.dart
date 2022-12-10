import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/DataClass.dart';

Future<List<DataClass>> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://brotherlike-navies.000webhostapp.com/people/people.php'));

  if (response.statusCode == 200) {

    return DataClass.fromJsonList(json.decode(response.body));
    //return result.map((e) => DataClass.fromJson(e)).toList();

  } else {

    throw Exception('Failed to load API');
  }
}



//void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<DataClass>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: fetchAlbum(),
            builder: (context, AsyncSnapshot<List<DataClass>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const Center(child: Text('Something went wrong'));
                }

                return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(snapshot.data![index].amount),
                          leading: Image.network(snapshot.data![index].avatar,height: 90,width: 90,),
                      );
                    });
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}