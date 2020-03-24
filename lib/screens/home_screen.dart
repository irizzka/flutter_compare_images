import 'dart:ui';
import 'package:flutter_img_cp/providers/images_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> _urlsList = ModalRoute.of(context).settings.arguments;
    print(_urlsList);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image comparator'),
      ),
      body: FutureBuilder<List<Image>>(
        future: Provider.of<ImagesProvider>(context).getListImg(_urlsList),
        builder: (BuildContext context, AsyncSnapshot<List<Image>> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(child: snapshot.data[0]),
                  Container(child: snapshot.data[1]),
                  Container(
                    child: Stack(
                      children: <Widget>[
                        snapshot.data[2],
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
