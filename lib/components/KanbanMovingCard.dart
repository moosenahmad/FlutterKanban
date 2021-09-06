import 'package:flutter/material.dart';

class KanbanMovingCard extends StatelessWidget {
  const KanbanMovingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: Card(
        color: Colors.lightBlue,
        child: ListTile(
          title: Text("Moving Here", style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}