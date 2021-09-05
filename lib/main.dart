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

Map<String, List<KanbanCard>> kanbanBoard = {
  "Column 1": [KanbanCard(cardName: "Card 1"),],
  "Column 2": [KanbanCard(cardName: "Card 2"),],
  "Column 3": [KanbanCard(cardName: "Card 3"),],
  "Column 4": [KanbanCard(cardName: "Card 4"),],
};

class _MyHomePageState extends State<MyHomePage> {
  DragTarget createDragColumn(String columnName){
    return DragTarget<KanbanCard>(
      builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
          ) {
        return Column(
          children: [
            SizedBox(
              height: 75,
              width: 250,
              child: Card(
                child: ListTile(title: Text(columnName),),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children:kanbanBoard[columnName]!.toList()
                ),
              ),
            )
          ],
        );
      },
      onAccept: (KanbanCard data) {
        setState(() {
          if(!kanbanBoard[columnName]!.contains(data)){
            kanbanBoard[columnName]!.add(data);
          }
          kanbanBoard[previousColumn]!.remove(data);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          createDragColumn("Column 1"),
          createDragColumn("Column 2"),
          createDragColumn("Column 3"),
          createDragColumn("Column 4"),
        ],
      ),
    );
  }
}

class KanbanCard extends StatelessWidget {
  const KanbanCard({
    Key? key,
    required this.cardName,
  }) : super(key: key);

  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Draggable<KanbanCard>(
        data: KanbanCard(cardName: cardName),
        child: SizedBox(
          height: 250,
          width: 250,
          child: Card(
            child: ListTile(title: Text(cardName),),
          ),
        ),
        feedback: SizedBox(
          height: 250,
          width: 250,
          child: Card(
            child: ListTile(title: Text(cardName),),
          ),
        ),
        childWhenDragging: Container(
          height: 250,
          width: 250,
          color: Colors.grey.shade300,
          child: Center(
            child: Text(cardName, style: TextStyle(color: Colors.white),),
          ),
        ),
        onDragStarted: (){
          for(String key in kanbanBoard.keys){
            if(kanbanBoard[key]!.contains(KanbanCard(key: this.key, cardName: this.cardName))){
              previousColumn = key;
              break;
            }
          }
        },
    );
  }
}
