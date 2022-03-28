import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Future<bool> OnNextPage(int nextPage);

class GridViewPagination extends StatefulWidget {
  final int itemCount;
  final double childAspectRatio;
  final OnNextPage onNextPage;
  final NullableIndexedWidgetBuilder itemBuilder;
  final Widget Function(BuildContext context) progressBuilder;

  GridViewPagination({
    required this.itemCount,
    required this.childAspectRatio,
    required this.itemBuilder,
    required this.onNextPage,
    required this.progressBuilder,
  });

  @override
  _GridViewPaginationState createState() => _GridViewPaginationState();
}

class _GridViewPaginationState extends State<GridViewPagination> {
  int currentPage = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification sn) {
        if (!isLoading && sn is ScrollUpdateNotification && sn.metrics.pixels == sn.metrics.maxScrollExtent) {
          setState(() {
            this.isLoading = true;
          });
          widget.onNextPage?.call(currentPage++)?.then((bool isLoaded) {
            setState(() {
              this.isLoading = false;
            });
          });
        }
        return true;
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: 2,
              childAspectRatio: widget.childAspectRatio,
            ),
            delegate: SliverChildBuilderDelegate(
              widget.itemBuilder,
              childCount: widget.itemCount,
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              addSemanticIndexes: true,
            ),
          ),
          if (isLoading)
            SliverToBoxAdapter(
              child: widget.progressBuilder?.call(context) ?? _defaultLoading(),
            ),
        ],
      ),
    );
  }

  Widget _defaultLoading() {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}