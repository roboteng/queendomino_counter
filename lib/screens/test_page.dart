import 'dart:math';

import 'package:flutter/material.dart';

final double legendHeight = 40.0;
final double legendWidth = 100.0;
final double cellHeight = 30.0;
final double cellWidth = 100.0;

final int xSize = 6;
final int ySize = 30;

class DynamicTable extends StatefulWidget {
  @override
  _DynamicTableState createState() => _DynamicTableState();
}

class _DynamicTableState extends State<DynamicTable> {
  final ScrollController _verticalTitleController = ScrollController();
  final ScrollController _verticalBodyController = ScrollController();

  final ScrollController _horizontalBodyController = ScrollController();
  final ScrollController _horizontalTitleController = ScrollController();
  final ScrollController _horizontalFooterController = ScrollController();

  _SyncScrollController _verticalSyncController;
  _SyncScrollController _horizontalSyncController;

  List<Key> headerKeys;
  List<List<Key>> dataKeys;

  @override
  void initState() {
    super.initState();
    _verticalSyncController = _SyncScrollController([
      _verticalTitleController,
      _verticalBodyController,
    ]);
    _horizontalSyncController = _SyncScrollController([
      _horizontalTitleController,
      _horizontalBodyController,
      _horizontalFooterController
    ]);
    headerKeys = List.generate(xSize, (index) => GlobalKey());
    dataKeys =
        List.generate(xSize, (x) => List.generate(ySize, (y) => GlobalKey()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QueenDomino Counter'),
      ),
      body: Column(
        children: [
          Header(
            controller: _horizontalTitleController,
            hSync: _horizontalSyncController,
            keys: headerKeys,
          ),
          Expanded(
            child: Row(
              children: [
                Sider(
                  controller: _verticalTitleController,
                  vSync: _verticalSyncController,
                ),
                DataSection(
                  hController: _horizontalBodyController,
                  vController: _verticalBodyController,
                  hSync: _horizontalSyncController,
                  vSync: _verticalSyncController,
                ),
              ],
            ),
          ),
          Footer(
            controller: _horizontalFooterController,
            hSync: _horizontalSyncController,
            keys: headerKeys,
          ),
        ],
      ),
    );
  }
}

class ColumnHeader extends StatelessWidget {
  final Widget child;

  const ColumnHeader({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: legendHeight,
      width: cellWidth,
      child: Center(
        child: this.child,
      ),
    );
  }
}

class Header extends StatelessWidget {
  final ScrollController controller;
  final _SyncScrollController hSync;
  final List<Key> keys;

  const Header({Key key, this.controller, this.hSync, this.keys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: legendWidth,
          height: legendHeight,
          child: Center(
            child: Text('Legend'),
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  xSize,
                  (i) => ColumnHeader(
                    key: keys[i],
                    child: Text('Header ${pow(2, i)}'),
                  ),
                ),
              ),
            ),
            onNotification: (ScrollNotification notification) {
              hSync.processNotification(
                notification,
                this.controller,
              );
              return true;
            },
          ),
        )
      ],
    );
  }
}

class Sider extends StatelessWidget {
  final ScrollController controller;
  final _SyncScrollController vSync;

  const Sider({Key key, this.controller, this.vSync}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: List.generate(
            ySize,
            (i) => SizedBox(
              width: legendWidth,
              height: cellHeight,
              child: Center(
                child: Text('Row ${i + 1}'),
              ),
            ),
          ),
        ),
      ),
      onNotification: (ScrollNotification notification) {
        vSync.processNotification(
          notification,
          this.controller,
        );
        return true;
      },
    );
  }
}

class Footer extends StatelessWidget {
  final ScrollController controller;
  final _SyncScrollController hSync;
  final List<Key> keys;

  const Footer({Key key, this.controller, this.hSync, this.keys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: legendWidth,
          height: legendHeight,
          child: Center(
            child: TextButton(
              child: Text('Legend'),
            ),
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  xSize,
                  (i) => ColumnHeader(
                    child: ElevatedButton(
                      child: Text('Footer ${i + 1}'),
                      onPressed: () => getSize(keys[i]),
                    ),
                  ),
                ),
              ),
            ),
            onNotification: (ScrollNotification notification) {
              hSync.processNotification(
                notification,
                this.controller,
              );
              return true;
            },
          ),
        )
      ],
    );
  }
}

class DataSection extends StatelessWidget {
  final ScrollController hController;
  final ScrollController vController;
  final _SyncScrollController hSync;
  final _SyncScrollController vSync;

  const DataSection(
      {Key key, this.hController, this.vController, this.vSync, this.hSync})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<ScrollNotification>(
        child: SingleChildScrollView(
          controller: hController,
          scrollDirection: Axis.horizontal,
          child: NotificationListener<ScrollNotification>(
            child: SingleChildScrollView(
              controller: vController,
              child: Column(
                children: List.generate(
                  ySize,
                  (y) => Row(
                    children: List.generate(
                        xSize,
                        (x) => SizedBox(
                              width: cellWidth,
                              height: cellHeight,
                              child: Center(
                                child: Text('$x, $y'),
                              ),
                            )),
                  ),
                ),
              ),
            ),
            onNotification: (ScrollNotification notification) {
              vSync.processNotification(
                notification,
                this.vController,
              );
              return true;
            },
          ),
        ),
        onNotification: (ScrollNotification notification) {
          hSync.processNotification(
            notification,
            this.hController,
          );
          return true;
        },
      ),
    );
  }
}

//copied from table_sticky_header
class _SyncScrollController {
  _SyncScrollController(List<ScrollController> controllers) {
    controllers
        .forEach((controller) => _registeredScrollControllers.add(controller));
  }

  final List<ScrollController> _registeredScrollControllers = [];

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        for (ScrollController controller in _registeredScrollControllers) {
          if (identical(_scrollingController, controller)) continue;
          controller.jumpTo(_scrollingController.offset);
        }
      }
    }
  }
}

void getSize(GlobalKey key) {
  Size size = key.currentContext.size;
  print(size);
}
