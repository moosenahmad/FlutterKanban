import 'package:flutter/material.dart';
import 'package:flutterkanbanboard/globals/GlobalVariables.dart';

class KanbanCard extends StatelessWidget {
  const KanbanCard({
    required Key key,
    required this.cardName,
  }) : super(key: key);

  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Draggable<KanbanCard>(
      key: key,
      data: KanbanCard(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        cardName: cardName,
      ),
      child: SizedBox(
        height: 250,
        width: 250,
        child: Card(
          child: ListTile(
            title: Text(cardName),
          ),
        ),
      ),
      feedback: SizedBox(
        height: 250,
        width: 250,
        child: Card(
          child: ListTile(
            title: Text(cardName),
          ),
        ),
      ),
      childWhenDragging: SizedBox(
        height: 250,
        width: 250,
        child: Card(
          color: Colors.grey.withOpacity(.1),
          child: ListTile(
            title: Text(cardName, style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
      onDragStarted: () {
        kanbanBoard.forEach((localKey, value) {
          var contains =
          value.firstWhere((element) => element.cardName == cardName,
              orElse: () => KanbanCard(
                key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                cardName: "NOT FOUND",
              ));
          if (contains.cardName != 'NOT FOUND') previousColumn = localKey;
        });
      },
      onDragCompleted: (){
        movingCard = "";
      },
    );
  }
}