import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subtitle/subtitle.dart';

class SubtitleBox extends StatefulWidget {
  final List<Subtitle> subtitles;
  final int currentPosition;
  final int currentDuration;

  SubtitleBox({
    required this.subtitles,
    required this.currentPosition,
    required this.currentDuration,
  });

  @override
  _SubtitleBoxState createState() => _SubtitleBoxState();
}

class _SubtitleBoxState extends State<SubtitleBox> {
  ScrollController _scrollController = ScrollController();
  Subtitle? _currentSubtitle;

  @override
  void didUpdateWidget(SubtitleBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToCurrentSubtitle();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentSubtitle = _getCurrentSubtitle(widget.currentPosition);

    return SizedBox(
      height: 300, // Adjust the height as per your requirements
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.subtitles.length,
        // itemExtent: 80, // Adjust the item extent as per your requirements
        itemBuilder: (context, index) {
          final subtitle = widget.subtitles[index];
          return Text(
            subtitle.data,
            style: TextStyle(
              fontSize: subtitle == _currentSubtitle ? 18 : 14,
              fontWeight: subtitle == _currentSubtitle
                  ? FontWeight.w900
                  : FontWeight.w500,
              color: subtitle == _currentSubtitle
                  ? Colors.blue
                  : Colors.black,
            ),
          );
        },
      ),
    );
  }

  void _scrollToCurrentSubtitle() {
    // if (_currentSubtitle != null) {
    //   int subtitleIndex = widget.subtitles.indexOf(_currentSubtitle!);
    //   if (subtitleIndex != -1) {
    //     double scrollOffset = subtitleIndex * 40; // Adjust based on itemExtent
    //     _scrollController.animateTo(
    //       scrollOffset,
    //       duration: const Duration(milliseconds: 300),
    //       curve: Curves.easeInOut,
    //     );
    //   }
    // }
  }

  Subtitle? _getCurrentSubtitle(int currentPosition) {
    for (int i = 0; i < widget.subtitles.length; i++) {
      if (currentPosition >=
          widget.subtitles[i].start.inMilliseconds &&
          currentPosition <=
              widget.subtitles[i].end.inMilliseconds) {
        return widget.subtitles[i];
      }
    }
    return null;
  }
}