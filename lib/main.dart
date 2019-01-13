import 'package:flutter/material.dart';

import 'drag_box.dart';
import 'bloc_provider.dart';
import 'lines_bloc.dart';
import 'line_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LinesBloc>(
      bloc: LinesBloc(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Stack(
            children: <Widget>[
              TheLines(),
              TheButtons(),
            ],
          )),
    );
  }
}

class TheButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LinesBloc linesBloc = BlocProvider.of<LinesBloc>(context);
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        print(event.position);
      },
      onPointerMove: (PointerMoveEvent event) {
        //print(event.position);
        linesBloc.changeLine.add(LineModel(Offset(10.0, 10.0), event.position));
      },
      child: Stack(
        children: <Widget>[
          DragBox(Offset(0.0, 0.0), 'Box One', Colors.blueAccent),
          DragBox(Offset(200.0, 0.0), 'Box Two', Colors.orange),
        ],
      ),
    );
  }
}

class TheLines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LinesBloc linesBloc = BlocProvider.of<LinesBloc>(context);
    return StreamBuilder<LineModel>(
      stream: linesBloc.theLine,
      builder: (BuildContext context, AsyncSnapshot<LineModel> snapshot) {
        return CustomPaint(
          painter: LinePainter(snapshot.data),
        );
      },
    );
  }
}

class LinePainter extends CustomPainter {
  final LineModel lineModel;

  LinePainter(this.lineModel);

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    print('shouldRepaint');
    return oldDelegate.lineModel != lineModel;
  }

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;
    if (lineModel != null) {
      canvas.drawLine(lineModel.start, lineModel.end, paint);
    }
  }
}
