import 'package:flutter/material.dart';

class LineModel {
  final Offset start;
  final Offset end;

  LineModel(this.start, this.end);

  @override
  String toString() {
    // TODO: implement toString
    return 'dx0: ${start.dx}, dy0: ${start.dy} | dx1: ${end.dx}, dy1: ${end.dy}';
  }
}
