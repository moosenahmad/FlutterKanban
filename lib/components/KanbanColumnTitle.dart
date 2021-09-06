import 'package:flutter/material.dart';

class KanbanColumnTitle extends StatelessWidget {
  const KanbanColumnTitle({
    Key? key,
    required this.columnTitle,
  }) : super(key: key);

  final String columnTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 250,
      child: Card(
        shadowColor: Colors.black,
        elevation: 2.0,
        child: ListTile(
          title: Text(columnTitle),
        ),
      ),
    );
  }
}