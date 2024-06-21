import 'dart:developer';

import 'package:flutter/material.dart';

class ScrollPositionDemo extends StatefulWidget {
   ScrollPositionDemo({super.key});
   final List<String> dataList = List.generate(50, (index) => 'Item $index');

  @override
  _ScrollPositionDemoState createState() => _ScrollPositionDemoState();
}

class _ScrollPositionDemoState extends State<ScrollPositionDemo> {
  final ScrollController _scrollController = ScrollController();
  int topVisibleIndex = -1;
  int bottomVisibleIndex = -1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Calculate the visible indices based on scroll position
    log("scroll position ${_scrollController.position}");
    setState(() {
      final firstVisibleItem = _scrollController.position.pixels;
      final lastVisibleItem =
          firstVisibleItem + _scrollController.position.viewportDimension+100;

      topVisibleIndex =
          (firstVisibleItem / 100).floor(); // Assuming each item has 100 height
      bottomVisibleIndex = (lastVisibleItem / 100).floor() - 1;
    });

    // Print or use the visible indices as needed
    log('Top Index: $topVisibleIndex, Bottom Index: $bottomVisibleIndex');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Sliver AppBar"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: widget.dataList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 90,
                // color: Colors.red,
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: [
                    if (index == 25) ...[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          color: Colors.purple,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Align(
                             alignment: Alignment.bottomCenter,
                            child: Text(
                              "Index data ${widget.dataList.length ~/ 2}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text("Left value", style:  TextStyle(
                                  color: Colors.white, fontSize: 16)),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Center value $index", style: const TextStyle(
                                  color: Colors.white, fontSize: 16)),
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("Right value", style: TextStyle(
                                  color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if ((bottomVisibleIndex) <= 25)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                color: Colors.purple,
                margin: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Index data ${widget.dataList.length ~/ 2}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          if (topVisibleIndex >= 25)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                color: Colors.purple,
                margin: const EdgeInsets.only(bottom: 10),
                child: Align(
                   alignment: Alignment.bottomCenter,
                  child: Text(
                    "Index data ${widget.dataList.length ~/ 2}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
