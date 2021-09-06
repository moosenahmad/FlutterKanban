import 'package:flutter/material.dart';
import 'package:flutterkanbanboard/components/KanbanCard.dart';

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