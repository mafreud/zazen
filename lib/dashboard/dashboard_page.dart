import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final double tileHeight = 100;
  final double groupHeaderHeight = 50;
  final double tileWidth = 280;

  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

enum IssueStatus { queue, inProgress, done }

class _DashboardPageState extends State<DashboardPage> {
  late LinkedHashMap<String, List<DraggableItem>> content;

  @override
  void initState() {
    // ignore: prefer_collection_literals
    content = LinkedHashMap();
    content.addAll(
      {
        IssueStatus.queue.name: [
          DraggableItem(
              id: "1",
              group: IssueStatus.queue.name,
              title: "Route Transitions",
              description: "-by Zachery"),
          DraggableItem(
            id: "2",
            group: IssueStatus.queue.name,
            title: "Referral System",
            description: "-by Zachery",
          ),
          DraggableItem(
            id: "3",
            group: IssueStatus.queue.name,
            title: "Mobile Number Input",
            description: "-by Zachery",
          ),
          DraggableItem(
            id: "4",
            group: IssueStatus.queue.name,
            title: "Flutter Challenges",
            description: "-by Zachery",
          ),
        ],
        IssueStatus.inProgress.name: [
          DraggableItem(
              id: "5",
              group: IssueStatus.inProgress.name,
              title: "Draggable Widgets",
              description: "-by Zachery"),
          DraggableItem(
              id: "6",
              group: IssueStatus.inProgress.name,
              title: "Credit Card Widget",
              description: "-by Zachery"),
          DraggableItem(
              id: "7",
              group: IssueStatus.inProgress.name,
              title: "Payment Screen",
              description: "-by Zachery"),
        ],
        IssueStatus.done.name: [
          DraggableItem(
              id: "8",
              group: IssueStatus.done.name,
              title: "Splash Screen",
              description: "-by Zachery"),
          DraggableItem(
              id: "9",
              group: IssueStatus.done.name,
              title: "Simple Buttons",
              description: "-by Zachery"),
          DraggableItem(
              id: "10",
              group: IssueStatus.done.name,
              title: "Neumorphic Buttons",
              description: "-by Rohan"),
        ],
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///SCAFFOLD STARTS HERE
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                },
              ),
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {
                  // FirebaseAuth.instance.signOut();
                  final result =
                      await FirebaseAuth.instance.getRedirectResult();
                  print('result:$result');
                },
              ),
            ],
          )
        ],
        iconTheme: const IconThemeData(color: Colors.green),
        centerTitle: false,
        title: const Center(
          child: Text(
            "座禅",
            style: TextStyle(
                color: Color(0xff37362F),
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
        elevation: 0.0,
        backgroundColor: const Color(0xffF5F6F8),
      ),
      backgroundColor: const Color(0xffF5F6F8),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.keys.map((String key) {
              return SizedBox(
                width: widget.tileWidth,
                child: buildTrelloBoard(key, content[key]!),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  buildTrelloBoard(String group, List<DraggableItem> draggableItems) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const Divider(
            height: 5,
          ),
          buildDraggableGroupHeader(group),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: draggableItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Draggable<DraggableItem>(
                    data: draggableItems[index],
                    child: ItemWidget(
                      item: draggableItems[index],
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.8,
                      child: ItemWidget(item: draggableItems[index]),
                    ),
                    feedback: SizedBox(
                      width: widget.tileWidth,
                      child: FloatingWidget(
                          child: ItemWidget(
                        item: draggableItems[index],
                      )),
                    ),
                  ),
                  buildDraggableItemDragTarget(group, index, widget.tileHeight),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  ///build methods to build groups and items
  buildDraggableItemDragTarget(group, targetPosition, double height) {
    return DragTarget<DraggableItem>(
      onWillAccept: (DraggableItem? data) {
        return content[group]!.isEmpty ||
            data!.id != content[group]![targetPosition].id;
      },
      onAccept: (DraggableItem data) {
        setState(() {
          content[data.group]!.remove(data);
          data.group = group;
          if (content[group]!.length > targetPosition) {
            content[group]!.insert(targetPosition + 1, data);
          } else {
            content[group]!.add(data);
          }
        });
      },
      builder: (BuildContext context, List<DraggableItem?> data,
          List<dynamic> rejectedData) {
        if (data.isEmpty) {
          return Container(
            height: height,
          );
        } else {
          return Column(
            children: [
              Container(
                height: height - 10,
              ),
              ...data.map((DraggableItem? item) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: Divider(
                    color: Color(0xffD0E9F2),
                    thickness: 10,
                  ),
                );
              }).toList()
            ],
          );
        }
      },
    );
  }

  buildDraggableGroupHeader(String group) {
    Widget header = SizedBox(
      height: widget.groupHeaderHeight,
      child: GroupHeaderWidget(title: group),
    );

    return Stack(
      children: [
        LongPressDraggable<String>(
          data: group,
          child: header,
          childWhenDragging: Opacity(
            opacity: 0.2,
            child: header,
          ),
          feedback: FloatingWidget(
            child: SizedBox(
              width: widget.tileWidth,
              child: header,
            ),
          ),
        ),
        buildDraggableItemDragTarget(group, 0, widget.groupHeaderHeight),
        DragTarget<String>(
          onWillAccept: (String? incomingListId) {
            return group != incomingListId;
          },
          onAccept: (String incomingGroup) {
            setState(
              () {
                LinkedHashMap<String, List<DraggableItem>> updatedCanvas =
                    LinkedHashMap();
                for (String key in content.keys) {
                  if (key == incomingGroup) {
                    updatedCanvas[group] = content[group]!;
                  } else if (key == group) {
                    updatedCanvas[incomingGroup] = content[incomingGroup]!;
                  } else {
                    updatedCanvas[key] = content[key]!;
                  }
                }
                content = updatedCanvas;
              },
            );
          },
          builder: (BuildContext context, List<String?> data,
              List<dynamic> rejectedData) {
            if (data.isEmpty) {
              return SizedBox(
                height: widget.groupHeaderHeight,
                width: widget.tileWidth,
              );
            } else {
              return SizedBox(
                height: widget.groupHeaderHeight,
                width: widget.tileWidth,
              );
            }
          },
        )
      ],
    );
  }
}

class GroupHeaderWidget extends StatelessWidget {
  final String? title;

  const GroupHeaderWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF5F6F8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        title: Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.more_horiz,
            ),
            Icon(
              Icons.add,
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final DraggableItem? item;

  const ItemWidget({Key? key, this.item}) : super(key: key);
  ListTile makeListTile(DraggableItem item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          item.title!,
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
        subtitle: Text(item.description!),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 1.2,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: makeListTile(item!),
    );
  }
}

class FloatingWidget extends StatelessWidget {
  final Widget? child;

  const FloatingWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.1,
      child: Opacity(
        opacity: 0.6,
        child: child,
      ),
    );
  }
}

///Draggable Item Structure with properties
class DraggableItem {
  final String id;
  String? group;
  final String? title;
  final String? description;

  DraggableItem({required this.id, this.group, this.title, this.description});
}
