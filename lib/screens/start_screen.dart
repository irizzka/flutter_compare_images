import 'package:flutter/material.dart';
import 'package:flutter_img_cp/screens/home_screen.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = '/start';

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _imageUrlController2 = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final FocusNode _secondUrl = FocusNode();

  //bool _isInit = true;

  // final List<String> _urlsList = <String>[];

  Future<void> _saveForm() async {
    final bool _isValid = _form.currentState.validate();
    if (_isValid) {
      _form.currentState.save();
      Navigator.of(context).pushNamed(HomeScreen.routeName,
          arguments: [_imageUrlController.text, _imageUrlController2.text]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input URL\'s'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                controller: _imageUrlController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter an image Url.';
                  }

                  if (value.startsWith('http') && !value.startsWith('https')) {
                    return 'Please enter a valid Url.';
                  }
                  if (!value.endsWith('.png') &&
                      !value.endsWith('.jpg') &&
                      !value.endsWith(',jpeg')) {
                    return 'Please enter a valid image Url.';
                  }
                  return null;
                },
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(_secondUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageUrlController2,
                focusNode: _secondUrl,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter an image Url.';
                  }
                  if (value.startsWith('http') && !value.startsWith('https')) {
                    return 'Please enter a valid Url.';
                  }
                  if (!value.endsWith('.png') &&
                      !value.endsWith('.jpg') &&
                      !value.endsWith(',jpeg')) {
                    return 'Please enter a valid image Url.';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  _saveForm();
                },
              ),
              SizedBox(
                width: 200.0,
                child: RaisedButton(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Compare'),
                  onPressed: () {
                    _saveForm();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _secondUrl.dispose();
    _imageUrlController.dispose();
    _imageUrlController2.dispose();
  }
}
