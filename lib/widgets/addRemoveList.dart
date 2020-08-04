import 'package:flutter/material.dart';

class AddRemoveList<T> extends StatefulWidget {
  final List<T> items; //starting list of items
  final T Function() newItem; // how a new item is created
  final Widget Function(T) childBuilder; // how to build a Widget on an item
  final void Function(List<T>) extractList;

  const AddRemoveList(
      {Key key, this.items, this.childBuilder, this.newItem, this.extractList})
      : super(key: key);

  List<T> getVisible() {
    return [];
  }

  @override
  _AddRemoveListState createState() => _AddRemoveListState<T>();
}

class _AddRemoveListState<T> extends State<AddRemoveList<T>> {
  List<T> items;
  List<bool> isVisible;

  List<T> getVisible() {
    List<T> values = [];
    for (int i in Iterable.generate(items.length)) {
      if (isVisible[i]) {
        values.add(items[i]);
      }
    }
    return values;
  }

  @override
  void initState() {
    items = widget.items;
    isVisible = List.filled(items.length, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: isVisible.length + 1,
      itemBuilder: (context, i) {
        if (i < isVisible.length) {
          if (isVisible[i]) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: widget.childBuilder(items[i]),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      isVisible[i] = false;
                      widget.extractList(getVisible());
                    });
                  },
                ),
              ],
            );
          } else {
            return Container();
          }
        } else {
          return Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    items.add(widget.newItem());
                    widget.extractList(getVisible());
                  });
                },
              ),
            ],
          );
        }
      },
    );
  }
}
