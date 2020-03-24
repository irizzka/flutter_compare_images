import 'package:flutter/material.dart';
import 'package:flutter_img_cp/screens/home_screen.dart';

class ConfigScreen extends StatefulWidget {
  static const String routeName = '/config';

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  double _horizontalAlign = 0;
  double _verticalAlign = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positioning'),
      ),
      body: FutureBuilder<Image>(
        // future: Provider.of<ImagesProvider>(context).compareImagesSize(),
        builder: (BuildContext context, AsyncSnapshot<Image> data) {
          if (data.hasData) {
            return Column(
              children: <Widget>[
                Container(
                  height: 400,
                  width: 400,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          //  child: Provider.of<ImagesProvider>(context).firstImage,
                          ),
                      Container(
                        child: Positioned(
                          width: MediaQuery.of(context).size.width,
                          left: _horizontalAlign,
                          top: _verticalAlign,
                          child: Opacity(
                            opacity: 0.5,
                            child: Container(
                                //  child: Provider.of<ImagesProvider>(context).secondImage,
                                // decoration: BoxDecoration(
                                //    color: Colors.red,
                                //  backgroundBlendMode: BlendMode.color),
                                ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    arrowBtn(Icon(Icons.arrow_back_ios), () {
                      // horizontalAlign = horizontalAlign >= 10 ? horizontalAlign - 10 : 0;
                      _horizontalAlign -= 10;
                    }),
                    arrowBtn(Icon(Icons.arrow_back), () {
                      _horizontalAlign--;
                    }),
                    arrowBtn(Icon(Icons.arrow_forward), () {
                      _horizontalAlign++;
                    }),
                    arrowBtn(Icon(Icons.arrow_forward_ios), () {
                      _horizontalAlign += 10;
                    }),
                  ],
                ),
                Row(
                  children: <Widget>[
                    arrowBtn(Icon(Icons.keyboard_arrow_up), () {
                      _verticalAlign -= 10;
                    }),
                    arrowBtn(Icon(Icons.arrow_upward), () {
                      _verticalAlign--;
                    }),
                    arrowBtn(Icon(Icons.arrow_downward), () {
                      _verticalAlign++;
                    }),
                    arrowBtn(Icon(Icons.keyboard_arrow_down), () {
                      _verticalAlign += 10;
                    }),
                  ],
                ),
                RaisedButton(
                  child: const Text('Apply'),
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName,
                        arguments: <double>[_horizontalAlign, _verticalAlign]);
                    //  Provider.of<ImagesProvider>(context, listen: false).changeOffset(
                    //    _horizontalAlign.round(), _verticalAlign.floor());
                  },
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget arrowBtn(Icon icon, Function func) {
    return IconButton(
      icon: icon,
      onPressed: () {
        setState(func);
      },
    );
  }
}
