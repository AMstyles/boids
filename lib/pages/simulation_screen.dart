import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:vector_math/vector_math.dart' as vector_math;
import 'package:flutter/material.dart';
import '../models/boid.dart';
import 'dart:async';

import '../utilities/my_rotation.dart';

class SimulationScreen extends StatefulWidget{
  const SimulationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SimulationScreenState();

}

class _SimulationScreenState extends State<SimulationScreen>{

  List<Boid> boids = [];
  vector_math.Vector2 center = vector_math.Vector2.zero();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    for(int i=0; i<Boid.numberOfBoids; i++) {
      if(i==Boid.numberOfBoids-1){
        boids.add(
            Boid(position: vector_math.Vector2(Random().nextDouble()* 1000, Random().nextDouble()*1000))
                ..isStudy=true
        );
      }
      else {
        boids.add(
            Boid(position: vector_math.Vector2(Random().nextDouble()* 1000, Random().nextDouble()*1000))

      );
      }
    }

    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        for(int i = 0; i<boids.length; i++){
          boids[i].update(boids);
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
  double width =  MediaQuery.of(context).size.width;
  double  height= MediaQuery.of(context).size.height;
  center = vector_math.Vector2(width/2, height/2);

  for(int i = 0; i<boids.length; i++){
    if(boids[i].position.x<0 ){
      boids[i].position.x = width;
    }

    if(boids[i].position.x>width ){
      boids[i].position.x = 0;
    }

    if(boids[i].position.y<0 ){
      boids[i].position.y = height;
    }

    if(boids[i].position.y>height ){
      boids[i].position.y = 0;
    }



  }

  return Container(
    width: constraints.maxWidth,
    height: constraints.maxHeight,
    decoration: BoxDecoration(
        color: Colors.grey[900]
    ),
    child: CustomPaint(
      painter: MyCustomPainter(boids:boids ),
    ),
  );
},

)

    );
  }
}

class MyCustomPainter extends CustomPainter{

  List<Boid> boids;

  MyCustomPainter({
    required this.boids
});



  @override
  void paint(Canvas canvas, Size size) {

    double sideLength = 10.0;

    //clear the canvas
    canvas.drawRect(Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)), Paint()..color = Colors.transparent);

    // TODO: implement paint
    double centerX = size.width/2;
    double centerY = size.height/2;


    var boidPaint = Paint()
    ..color=Colors.white
    ;

    var studyBoidPaint = Paint()
      ..color=Colors.redAccent
    ;

    var studyBoidPaintOutline = Paint()
      ..color=Colors.redAccent
    ;

    //todo: draw the boids
    for(Boid boid in boids) {

      if(boid.isStudy){
        canvas.drawCircle(Offset(boid.position.x, boid.position.y), 5.0, studyBoidPaint);
        canvas.drawCircle(Offset(boid.position.x, boid.position.y), Boid.perception, studyBoidPaintOutline..style=PaintingStyle.stroke);
        vector_math.Vector2 alignment = boid.align(boids);
        if (kDebugMode) {
          //print(alignment);
        }
        //canvas.drawLine(Offset(boid.position.x, boid.position.y), Offset((boid.position.x + alignment.x), (boid.position.y + alignment.y)*1.1), studyBoidPaintOutline..style=PaintingStyle.stroke);


        for(Boid other in boids){
          if(boid.position.distanceTo(other.position)!=0 && boid.velocity.angleTo(other.position-boid.position)<pi/2 ){
            if(boid.position.distanceTo(other.position)<Boid.perception){
              canvas.drawLine(Offset(boid.position.x, boid.position.y), Offset(other.position.x, other.position.y), studyBoidPaintOutline
                ..style=PaintingStyle.stroke
                  ..color=Colors.greenAccent

              );
            }
            // smallestDistance = boid.position.distanceTo(other.position);
            // closestBoid = other.position;
          }
        }

      }
      else{

        List<Offset> vertices = [
          Offset(boid.position.x, boid.position.y - sideLength), // Top vertex
          Offset(boid.position.x - sideLength / 2, boid.position.y + sideLength / 2), // Bottom-left vertex
          Offset(boid.position.x + sideLength / 2, boid.position.y + sideLength / 2), // Bottom-right vertex
        ];

        List<Offset> verticesRotated = [];

        double angle = atan2(boid.velocity.y, boid.velocity.x) + pi / 2;

        for(Offset vertex in vertices){
          verticesRotated.add(MyRotation.rotate(vertex, Offset(boid.position.x, boid.position.y), angle));
        }


        canvas.drawPath(
          Path()..addPolygon(verticesRotated, true),
          boidPaint,
        );

        //canvas.drawCircle(Offset(boid.position.x, boid.position.y), 5.0, boidPaint);


      }


    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}