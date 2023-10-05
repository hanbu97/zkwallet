import 'package:flutter/material.dart';
import '/utils/config/styles.dart';

class GasButton extends StatefulWidget {
  final String label;
  final Function onPressed;
  final bool isSelected;

  const GasButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  _GasButtonState createState() => _GasButtonState();
}

class _GasButtonState extends State<GasButton> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = widget.isSelected
        ? const Color.fromRGBO(222, 234, 253, 1)
        : Styles.contentBackground;
    Color textColor = widget.isSelected ? Colors.blue : Colors.grey;
    Color borderColor = widget.isSelected ? Colors.blue : Colors.transparent;

    var isSelected = false;

    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onPressed();
      },
      child: widget.label == "Customize"
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: borderColor),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          : Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: borderColor),
              ),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 15,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "0.000274FIL",
                        style: TextStyle(
                          fontSize: 10,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "0.00274 \$",
                        style: TextStyle(
                          fontSize: 10,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "< 5 Min",
                        style: TextStyle(
                          fontSize: 10,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ))),
    );
  }
}

class GasButtonRow extends StatefulWidget {
  final List<String> labels;
  final Function(int) onButtonPressed;

  const GasButtonRow({
    Key? key,
    required this.labels,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  _GasButtonRowState createState() => _GasButtonRowState();
}

class _GasButtonRowState extends State<GasButtonRow> {
  List<bool> _isSelectedList = [];
  TextEditingController _gascontroller =
      TextEditingController(text: '0.4431821888');

  @override
  void initState() {
    super.initState();
    _isSelectedList = List.filled(widget.labels.length, false);
    _isSelectedList[1] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: widget.labels.asMap().entries.map((entry) {
            int index = entry.key;
            String label = entry.value;

            return Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AspectRatio(
                    aspectRatio: 0.75,
                    child: GasButton(
                      label: label,
                      onPressed: () {
                        setState(() {
                          for (int i = 0; i < _isSelectedList.length; i++) {
                            _isSelectedList[i] = false;
                          }
                          _isSelectedList[index] = true;
                        });
                        widget.onButtonPressed(index);
                      },
                      isSelected: _isSelectedList[index],
                    ),
                  )),
            );
          }).toList(),
        ),
        _isSelectedList[3] == true
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Miner Rate(base fee + gas premium)",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _gascontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // hintText: 'Please enter amount',
                            ),
                          ),
                        ),
                        Text(
                          'nanoFIL',
                          // style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              )
            : SizedBox(
                height: 15,
              )
      ],
    );
  }
}
