import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget header;
  final Widget header2;
  final Color? iconColor;
  final List<Widget> children;

  const CustomExpansionTile({super.key, required this.header,required this.header2, required this.children, required this.iconColor});

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: _toggleExpansion,
          child: Container(
            color: Colors.transparent,
            // padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.header,
                    Icon(_isExpanded ? Icons.keyboard_arrow_up: Icons.keyboard_arrow_down,color: widget.iconColor,),
                  ],
                ),
                widget.header2
              ],
            ),
          ),
        ),
        _isExpanded
            ? Column(children: widget.children)
            : Container(),
      ],
    );
  }
}