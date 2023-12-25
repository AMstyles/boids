import 'dart:math';
import 'package:vector_math/vector_math.dart';


class Boid{

  static var rng = Random();
  static double perception = 100.0;
  static double maxForce = 0.03;
  static double maxSpeed = 2;
  static int numberOfBoids = 100;
  static bool isLooking = false;
  static bool isAvoiding = false;
  static bool isCohering = false;

  static double cohesionWeight = 0.4;
  static double separationWeight = 1;
  static double alignmentWeight = 0.5;

  static void setLooking(bool value){
    isLooking = value;
  }

  static void setPerception(double value){
    perception = value;
  }

  static void setMaxForce(double value){
    maxForce = value;
  }

  static void setMaxSpeed(double value){
    maxSpeed = value;
  }

  static void setNumberOfBoids(int value){
    numberOfBoids = value;
  }

  static void setAvoiding(bool value){
    isAvoiding = value;
  }

  static void setCohering(bool value){
    isCohering = value;
  }

  static void setAlignmentWeight(double value){
    alignmentWeight = value;
  }

  static void setSeparationWeight(double value){
    separationWeight = value;
  }

  static void setCohesionWeight(double value){
    cohesionWeight = value;
  }

  Vector2 position;
  Vector2 velocity = Vector2((rng.nextDouble() * 2) - 1, (rng.nextDouble() * 2) - 1)* 2;
  Vector2 acceleration = Vector2.zero();

  bool isStudy = false;

  Boid({
    required  this.position
});

  void update(List<Boid> boids){


      flock(boids);

    position.add(velocity);
    velocity.add(acceleration);

    // Limit the speed
    velocity.clampScalar(-maxSpeed, maxSpeed);


  }

  Vector2 align(List<Boid> boids){

    Vector2 steering = Vector2.zero();
    double total = 0;

    for(Boid other in boids){
        if(position.distanceTo(other.position)<= Boid.perception && position.distanceTo(other.position)!=0 && velocity.angleTo(other.position-position)<pi/2 ){
          steering.add(other.velocity);
          total++;
        }
    }

    if(total!=0) {
      steering/=total;
       steering.normalize();
       steering.scale(maxSpeed);
      steering.sub(velocity);
      steering.clampScalar(-Boid.maxForce, Boid.maxForce);
    }



    return steering;
  }
  Vector2 separation(List<Boid> boids) {
    Vector2 steering = Vector2.zero();
    double desiredSeparation = 25.0;
    int count = 0;

    for (Boid other in boids) {
      double distance = position.distanceTo(other.position);

      if (distance > 0 && distance < desiredSeparation  ) {
        Vector2 diff = position.clone()..sub(other.position);
        diff.normalize();
        diff.scale(1 / distance);
        steering.add(diff);
        count++;
      }
    }

    if (count > 0) {
      steering.scale(1 / count);
    }

    if (steering.length > 0) {
      steering.normalize();
      steering.scale(maxSpeed);
      steering.sub(velocity);
      steering.clampScalar(-maxForce, maxForce);
    }

    return steering;
  }
  Vector2 cohesion(List<Boid> boids) {
    Vector2 steering = Vector2.zero();
    double perceptionRadius = perception * 2.0;
    int count = 0;

    for (Boid other in boids) {
      double distance = position.distanceTo(other.position);

      if (distance > 0 && distance < perceptionRadius && velocity.angleTo(other.position-position)<pi/2 ) {
        steering.add(other.position);
        count++;
      }
    }

    if (count > 0) {
      steering.scale(1 / count);
      steering.sub(position);
      steering.normalize();
      steering.scale(maxSpeed);
      steering.sub(velocity);
      steering.clampScalar(-maxForce, maxForce);
    }

    return steering;
  }

  void flock(List<Boid> boids){
    Vector2 alignment = align(boids);
    Vector2 separationForce = separation(boids);
    Vector2 cohesionForce = cohesion(boids);

    // You can adjust the weights for alignment and separation based on your preference.
    alignment.scale(alignmentWeight);
    separationForce.scale(separationWeight);
    cohesionForce.scale(cohesionWeight);

    if(Boid.isLooking)
      {acceleration.add(alignment);}
    if(Boid.isAvoiding) {
      acceleration.add(separationForce);
    }
    if(Boid.isCohering) {
      acceleration.add(cohesionForce);
    }

    acceleration/=3;
  }

}