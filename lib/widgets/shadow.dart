import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShadowMaskWidget extends StatefulWidget {
  final bool isShown;
  final Function? closeShadow;

  const ShadowMaskWidget({Key? key, this.isShown = false, this.closeShadow})
      : super(key: key);

  @override
  State<ShadowMaskWidget> createState() => _ShadowMaskWidgetState();
}

class _ShadowMaskWidgetState extends State<ShadowMaskWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isShown
        ? Positioned.fill(
            child: GestureDetector(
            onTap: () => {
              setState(() {
                widget.closeShadow!();
              })
            },
            child: Container(
                color: Colors.black.withOpacity(0.5), child: const SizedBox()),
          ))
        : const SizedBox();
  }
}
