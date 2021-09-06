import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String previousColumn = "";

String movingCard = "";

Map<String, List<KanbanCard>> kanbanBoard = {
  "Column 1": [
    KanbanCard(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      cardName: "Card 1",
    ),
  ],
  "Column 2": [
    KanbanCard(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      cardName: "Card 2",
    ),
  ],
  "Column 3": [
    KanbanCard(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      cardName: "Card 3",
    ),
  ],
  "Column 4": [
    KanbanCard(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      cardName: "Card 4",
    ),
  ],
  "Column 5": [
    KanbanCard(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      cardName: "Card 5",
    ),
  ],
};

class _MyHomePageState extends State<MyHomePage> {
  DragTarget createDragColumn(String columnName) {
    return DragTarget<KanbanCard>(
      builder: (
          context,
          accepted,
          rejected,
          ) {
        return Column(
          children: [
            SizedBox(
              height: 75,
              width: 250,
              child: Card(
                child: ListTile(
                  title: Text(columnName),
                ),
              ),
            ),
            (movingCard == columnName && previousColumn != columnName) ? Container(
              height: 250,
              width: 250,
              color: Colors.lightBlue.withOpacity(.1),
              child: Center(
                child: Text(
                  "Moving Here",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ) : Container(),
            Expanded(
              child: Container(
                width: 250,
                child: ReorderableListView(
                  scrollDirection: Axis.vertical,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final KanbanCard item = kanbanBoard[columnName]!.removeAt(oldIndex);
                      kanbanBoard[columnName]!.insert(newIndex, item);
                    });
                  },
                  children: kanbanBoard[columnName]!.reversed.toList(),
                ),
              ),
            )
          ],
        );
      },
      onWillAccept: (data) {
        setState(() {
          movingCard = columnName;
        });
        return true;
      },
      onAccept: (KanbanCard data) {
        setState(() {
          var isThere = kanbanBoard[columnName]!
              .firstWhere((element) => element.cardName == data.cardName,
              orElse: () => KanbanCard(
                key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                cardName: 'NOT FOUND',
              ));
          if (isThere.cardName == 'NOT FOUND') {
            kanbanBoard[columnName]!.add(data);
          }
          if (columnName != previousColumn)
            kanbanBoard[previousColumn]
                ?.removeWhere((element) => element.cardName == data.cardName);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            createDragColumn("Column 1"),
            createDragColumn("Column 2"),
            createDragColumn("Column 3"),
            createDragColumn("Column 4"),
            createDragColumn("Column 5"),
          ],
        ),
      ),
    );
  }
}

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
      childWhenDragging: Container(
        height: 250,
        width: 250,
        color: Colors.grey.withOpacity(.1),
        child: Center(
          child: Text(
            cardName,
            style: TextStyle(color: Colors.white),
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