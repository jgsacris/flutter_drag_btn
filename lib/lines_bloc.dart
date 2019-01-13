import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';
import 'line_model.dart';

class LinesBloc extends BlocBase {
  BehaviorSubject<LineModel> _theLine = BehaviorSubject<LineModel>();

  Sink<LineModel> get changeLine => _theLine.sink;
  Stream<LineModel> get theLine => _theLine.stream;

  LinesBloc() {
    _theLine.stream.listen((data) {
      print(data);
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error " + error);
    });
  }

  @override
  void dispose() {
    _theLine.close();
  }
}
