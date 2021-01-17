import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'basic animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GlassOfLiquidDemo(),
    );
  }
}

class GlassOfLiquidDemo extends StatefulWidget {
  @override
  _GlassOfLiquidState createState() => _GlassOfLiquidState();
}

class _GlassOfLiquidState extends State<GlassOfLiquidDemo> {
  double fullnessRatio = 0.7;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        children: [
          SizedBox(height: 150),
          Center(
            child: Container(
              //color: Colors.yellow,
              width: 100,
              height: 180,
              child: CustomPaint(
                  painter: GlassOfLiquid(
                      skew: 0.2, topBottomRatio: 0.7, fullness: fullnessRatio)),
            ),
          ),
          Slider(
              value: fullnessRatio,
              onChanged: (newValue) {
                setState(() {
                  this.fullnessRatio = newValue;
                });
              })
        ],
      ),
    );
  }
}

class GlassOfLiquid extends CustomPainter {
  final double skew;
  final double topBottomRatio;
  final double fullness;

  GlassOfLiquid({this.topBottomRatio, this.skew, this.fullness});
  @override
  void paint(Canvas canvas, Size size) {
    Paint glass = Paint()
      ..color = Colors.white.withAlpha(150)
      ..style = PaintingStyle.fill;
    Paint edges = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    Rect top = Rect.fromLTRB(0, 0, size.width, size.width * skew);
    Rect bottom = Rect.fromCenter(
      center: Offset(
        size.width * 0.5,
        size.height - size.width * .5 * skew * topBottomRatio,
      ),
      height: size.width * skew,
      width: size.width * topBottomRatio,
    );

    Paint milkColor = Paint()
      ..color = Color.fromARGB(255, 235, 235, 235)
      ..style = PaintingStyle.fill;

    Paint milkTopLiquid = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Rect liquidTop = Rect.lerp(bottom, top, fullness);

    Path cupPath = Path()
      ..moveTo(top.left, top.top + top.height * .5)
      ..arcTo(top, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * .5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(top.left, top.top + top.height * .5);

    Path liquidPath = Path()
      ..moveTo(liquidTop.left, liquidTop.top + liquidTop.height * .5)
      ..arcTo(liquidTop, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * .5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(liquidTop.left, liquidTop.top + liquidTop.height * .5);

    canvas.drawPath(cupPath, edges);

    canvas.drawPath(liquidPath, milkColor);
    canvas.drawOval(liquidTop, milkTopLiquid);

    canvas.drawPath(cupPath, glass);
    canvas.drawOval(top, edges);

    //canvas.drawOval(top, glass);
    // canvas.drawOval(bottom, glass);
  }

  @override
  bool shouldRepaint(GlassOfLiquid old) =>
      old.fullness != fullness ||
      old.skew != skew ||
      old.topBottomRatio != topBottomRatio;
}
