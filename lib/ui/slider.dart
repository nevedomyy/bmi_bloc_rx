import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../bloc/provider.dart';
import '../bloc/bloc.dart';


class CustomSlider extends StatefulWidget{
  final _label;
  final _start;
  final _end;
  CustomSlider(this._label, this._start, this._end);
  @override
  _CustomSlider createState() => _CustomSlider(_label, _start, _end);
}

class _CustomSlider extends State<CustomSlider>{
  final _label;
  final _start;
  final _end;
  BLoC _bloc;
  Offset _offset;

  _CustomSlider(this._label, this._start, this._end);

  @override
  initState() {
    super.initState();
    _offset = Offset(0, 0);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width/2;
    _bloc = BLoCProvider.of(context);
    return SizedBox(
      width: double.infinity,
      height: 136.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: StreamBuilder(
                    stream: _bloc.sliderStream(_label),
                    builder: (context, snapshot){
                      return Text(
                          snapshot.data.toString(),
                          style: Theme.of(context).textTheme.body1
                      );
                    },
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  _label,
                  style: Theme.of(context).textTheme.body2
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 36.0),
            child: CustomPaint(
              size: Size.infinite,
              painter: SliderPainter(),
            ),
          ),
          Transform.translate(
            offset: _offset,
            child: GestureDetector(
              onPanUpdate: (data){
                double i = 100*data.globalPosition.dx/w;
                if(i < 10) i=10;
                if(i > 190) i=190;
                int value = (_start+(i-10)*(_end-_start)/180).toInt();
                _offset = Offset(w*math.sin((i*0.6-60)*math.pi/180), -100+100*math.cos((i*0.6-60)*math.pi/180));
                _bloc.changeValue(_label, value);
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      color: Colors.white,
                      boxShadow: [BoxShadow(spreadRadius: 1, color: Colors.black12)]
                  ),
                  child: SizedBox.fromSize(size: Size.square(26.0)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SliderPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> points = List();
    final h = size.height;
    final w = size.width/2;
    for(int i=-60; i<=60; i++){
      points.add(Offset(w+w*math.sin(i*math.pi/180), h*math.cos(i*math.pi/180)));
    }
    final path = Path();
    path.addPolygon(points, false);
    canvas.drawPath(path, Paint()..color = Colors.white24..strokeWidth = 4..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}