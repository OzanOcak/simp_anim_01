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
          width: 120,
          height: 180,
          child: CustomPaint(painter: GlassOfLiquid(skew: 0.2)),
        ),
      ),
    );
  }
}

class GlassOfLiquid extends CustomPainter {
  final double skew;

  GlassOfLiquid({this.skew});
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

    canvas.drawOval(top, glass);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
