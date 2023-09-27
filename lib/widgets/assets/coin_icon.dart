// if icon exists in assets, use it, else Icons.help
// import 'package:bizhi/utils/file.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<SvgPicture?> tryLoadSvg(String path) async {
  try {
    final bytes = await rootBundle.load(path);
    final svg = SvgPicture.memory(
      bytes.buffer.asUint8List(),
      allowDrawingOutsideViewBox: true,
    );
    return svg;
  } catch (e) {
    return null;
  }
}

Widget getCoinIcon(String coin) {
  var imgDir = coin.toLowerCase();
  imgDir = 'assets/coins/$imgDir.svg';
  String imgUrl =
      'https://assets.coincap.io/assets/icons/${coin.toLowerCase()}@2x.png';

  return FutureBuilder<SvgPicture?>(
    future: tryLoadSvg(imgDir),
    builder: (BuildContext context, AsyncSnapshot<SvgPicture?> snapshot) {
      // print("loading icon: " + coin);
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData && snapshot.data != null) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double size = constraints.biggest.height > 40
                  ? 40
                  : constraints.biggest.height;

              return ClipOval(
                child: Container(
                  height: size,
                  width: size,
                  child: snapshot.data,
                ),
              );
            },
          );
        } else {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double size = constraints.biggest.height > 40
                  ? 40
                  : constraints.biggest.height;

              return ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  height: size,
                  width: size,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.help, size: size),
                ),
              );
            },
          );
        }
      } else {
        return CircularProgressIndicator(); // 显示加载中的指示器
      }
    },
  );
}
