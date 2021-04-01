import 'package:flutter/material.dart';

final double legendHeight = 40.0;
final double legendWidth = 100.0;
final double cellHeight = 48.0;
final double cellWidth = 100.0;

class DynamicTable extends StatefulWidget {
  final int columnsLength;
  final int rowsLength;
  final Widget Function(int) columnsTitleBuilder;
  final Widget Function(int) rowsTitleBuilder;
  final Widget Function(int) footerBuilder;
  final Widget Function(int, int) contentCellBuilder;
  final Widget northWestTitle;
  final Widget southWestTitle;

  const DynamicTable({
    Key key,
    this.columnsLength,
    this.rowsLength,
    this.columnsTitleBuilder,
    this.rowsTitleBuilder,
    this.footerBuilder,
    this.contentCellBuilder,
    this.southWestTitle,
    this.northWestTitle,
  }) : super(key: key);
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
    _init();
  }

  void _init() {
    _verticalSyncController = _SyncScrollController([
      _verticalTitleController,
      _verticalBodyController,
    ]);
    _horizontalSyncController = _SyncScrollController([
      _horizontalTitleController,
      _horizontalBodyController,
      _horizontalFooterController
    ]);
    headerKeys = List.generate(widget.columnsLength, (index) => GlobalKey());
    dataKeys = List.generate(widget.columnsLength,
        (x) => List.generate(widget.rowsLength, (y) => GlobalKey()));
  }

  @override
  void didUpdateWidget(covariant DynamicTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          controller: _horizontalTitleController,
          hSync: _horizontalSyncController,
          keys: headerKeys,
          columnTitleBuilder: widget.columnsTitleBuilder,
          columnsLength: widget.columnsLength,
          leading: widget.northWestTitle,
        ),
        Expanded(
          child: Row(
            children: [
              _Sider(
                controller: _verticalTitleController,
                vSync: _verticalSyncController,
                rowsLength: widget.rowsLength,
                rowTitleBuilder: widget.rowsTitleBuilder,
              ),
              _DataSection(
                hController: _horizontalBodyController,
                vController: _verticalBodyController,
                hSync: _horizontalSyncController,
                vSync: _verticalSyncController,
                rowsLength: widget.rowsLength,
                columnsLength: widget.columnsLength,
                contentCellBuilder: widget.contentCellBuilder,
              ),
            ],
          ),
        ),
        _Footer(
          controller: _horizontalFooterController,
          hSync: _horizontalSyncController,
          keys: headerKeys,
          columnsLength: widget.columnsLength,
          footerBuilder: widget.footerBuilder,
          leading: widget.southWestTitle,
        ),
      ],
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  final Widget child;

  const _ColumnHeader({
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

class _Header extends StatelessWidget {
  final ScrollController controller;
  final _SyncScrollController hSync;
  final List<Key> keys;
  final Widget Function(int) columnTitleBuilder;
  final int columnsLength;
  final Widget leading;

  const _Header({
    Key key,
    this.controller,
    this.hSync,
    this.keys,
    this.columnTitleBuilder,
    this.columnsLength,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: legendWidth,
          height: legendHeight,
          child: Center(
            child: leading,
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  columnsLength,
                  (i) => _ColumnHeader(
                    key: keys[i],
                    child: columnTitleBuilder(i),
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

class _Sider extends StatelessWidget {
  final ScrollController controller;
  final _SyncScrollController vSync;
  final Widget Function(int) rowTitleBuilder;
  final int rowsLength;

  const _Sider({
    Key key,
    this.controller,
    this.vSync,
    this.rowTitleBuilder,
    this.rowsLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: List.generate(
            rowsLength,
            (i) => SizedBox(
              width: legendWidth,
              height: cellHeight,
              child: Center(
                child: rowTitleBuilder(i),
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

class _Footer extends StatelessWidget {
  final ScrollController controller;
  final _SyncScrollController hSync;
  final List<Key> keys;
  final Widget Function(int) footerBuilder;
  final int columnsLength;
  final Widget leading;

  const _Footer({
    Key key,
    this.controller,
    this.hSync,
    this.keys,
    this.footerBuilder,
    this.columnsLength,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: legendWidth,
          height: legendHeight,
          child: Center(
            child: leading,
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            child: SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  columnsLength,
                  (i) => _ColumnHeader(
                    child: footerBuilder(i),
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

class _DataSection extends StatelessWidget {
  final ScrollController hController;
  final ScrollController vController;
  final _SyncScrollController hSync;
  final _SyncScrollController vSync;
  final Widget Function(int, int) contentCellBuilder;
  final int columnsLength;
  final int rowsLength;

  const _DataSection({
    Key key,
    this.hController,
    this.vController,
    this.vSync,
    this.hSync,
    this.contentCellBuilder,
    this.columnsLength,
    this.rowsLength,
  }) : super(key: key);
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
                  rowsLength,
                  (y) => Row(
                    children: List.generate(
                        columnsLength,
                        (x) => SizedBox(
                            width: cellWidth,
                            height: cellHeight,
                            child: contentCellBuilder(x, y))),
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

class _SyncScrollController {
  _SyncScrollController(List<ScrollController> controllers) {
    controllers.forEach(
      (controller) => _registeredScrollControllers.add(controller),
    );
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
