import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImagesProvider extends ChangeNotifier {
  Future<Image> getImage(String url) async {
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return Image.memory(response.bodyBytes);
    } else {
      return null;
    }
  }

  Future<dynamic> getImgBytes(String url) async {
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return img.decodeImage(response.bodyBytes);
    } else {
      print('oooops');
      return null;
    }
  }

  Future<List<Image>> getListImg(List<String> urls) async {
    final img.Image firstImg = await getImgBytes(urls[0]);
    final img.Image secondImg = await getImgBytes(urls[1]);

    ///  так сделано специально, т.к firstImg и secondImg были безвозвратно изменены
    final Image _img1 = Image.network(urls[0]);
    final Image _img2 = Image.network(urls[1]);

    int firstP;
    int secondP;

    img.grayscale(firstImg);
    img.grayscale(secondImg);
    img.normalize(secondImg, 0, 255);
    img.normalize(firstImg, 0, 255);

    final int wb1 = firstImg.getWhiteBalance();
    final int wb2 = secondImg.getWhiteBalance();

    double v1 = 0;
    double v2 = 0;
    double k1 = 0;
    double k2 = 0;

    final int width =
        firstImg.width > secondImg.width ? secondImg.width : firstImg.width;
    final int height =
        firstImg.height > secondImg.height ? secondImg.height : firstImg.height;
    final img.Image thirdImg = img.Image(width, height);

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        firstP = firstImg.getPixel(i, j);
        secondP = secondImg.getPixel(i, j);

        v1 += (img.rgbToHsl(
            img.getRed(firstP), img.getGreen(firstP), img.getBlue(firstP)))[2];
        v2 += (img.rgbToHsl(img.getRed(secondP), img.getGreen(secondP),
            img.getBlue(secondP)))[2];
      }
    }

    v1 = v1 / (width * height);
    v2 = v2 / (width * height);

    k1 = (v1 + v2) / 2 * v1;
    k2 = (v1 + v2) / 2 * v2;

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        firstP = firstImg.getPixel(i, j);
        secondP = secondImg.getPixel(i, j);

        v1 += (img.rgbToHsl(
            img.getRed(firstP), img.getGreen(firstP), img.getBlue(firstP)))[2];

        v2 += (img.rgbToHsl(img.getRed(secondP), img.getGreen(secondP),
            img.getBlue(secondP)))[2];

        final List<num> hslImg1 = img.rgbToHsl(
            img.getRed(firstP), img.getGreen(firstP), img.getBlue(firstP));

        final List<int> rgb1 =
            img.hslToRgb(hslImg1[0], hslImg1[1], hslImg1[2] * k2);

        final List<num> hslImg2 = img.rgbToHsl(
            img.getRed(secondP), img.getGreen(secondP), img.getBlue(secondP));

        final List<int> rgb2 =
            img.hslToRgb(hslImg2[0], hslImg2[1], hslImg2[2] * k1);

        if ((rgb1[0] - rgb2[0]).abs() >
            //    ((wb1 - wb2).abs() +
            //        (img.getLuminance(rgb1[0]) - img.getLuminance(rgb2[0]))
            //          .abs())) {
            (wb1 - wb2).abs()) {
          thirdImg.setPixel(i, j, 25525525510);
        }
      }
    }

    return <Image>[_img1, _img2, Image.memory(img.encodePng(thirdImg))];
  }
}
