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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Container(
          //color: Colors.yellow,
          width: 120,
          height: 180,
          child: CustomPaint(
              painter: GlassOfLiquid(skew: 0.2, topBottomRatio: 0.7)),
        ),
      ),
    );
  }
}

class GlassOfLiquid extends CustomPainter {
  final double skew;
  final double topBottomRatio;

  GlassOfLiquid({this.topBottomRatio, this.skew});
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

    canvas.drawOval(top, glass);
    canvas.drawOval(bottom, glass);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
