import 'dart:math';

import 'package:flutter/cupertino.dart';

class BoidSettings extends ChangeNotifier{

   var rng = Random();
   double perception = 100.0;
   double maxForce = 0.03;
   double maxSpeed = 2;
   int numberOfBoids = 100;
   bool isLooking = false;

   void setLooking(bool value){
    isLooking = value;
  }

   void setPerception(double value){
    perception = value;
  }

   void setMaxForce(double value){
    maxForce = value;
  }

   void setMaxSpeed(double value){
    maxSpeed = value;
  }

   void setNumberOfBoids(int value){
    numberOfBoids = value;
  }

   void setAll(double perception, double maxForce, double maxSpeed, int numberOfBoids){
   perception = perception;
   maxForce = maxForce;
   maxSpeed = maxSpeed;
   numberOfBoids = numberOfBoids;
  }

   void setRandom(){
   perception = rng.nextDouble()*100;
   maxForce = rng.nextDouble()*0.1;
   maxSpeed = rng.nextDouble()*10;
   numberOfBoids = rng.nextInt(1000);
  }

   void setDefault(){
   perception = 100.0;
   maxForce = 0.03;
   maxSpeed = 2;
   numberOfBoids = 100;
  }

   void setRandomPerception(){
   perception = rng.nextDouble()*100;
  }

   void setRandomMaxForce(){
   maxForce = rng.nextDouble()*0.1;
  }

   void setRandomMaxSpeed(){
   maxSpeed = rng.nextDouble()*10;
  }

   void setRandomNumberOfBoids(){
   numberOfBoids = rng.nextInt(1000);
  }

   void setRandomAll(){
   perception = rng.nextDouble()*100;
   maxForce = rng.nextDouble()*0.1;
   maxSpeed = rng.nextDouble()*10;
   numberOfBoids = rng.nextInt(1000);
  }

   void setRandomLooking(){
   isLooking = rng.nextBool();
  }

   void setRandomAllExceptLooking(){
   perception = rng.nextDouble()*100;
   maxForce = rng.nextDouble()*0.1;
   maxSpeed = rng.nextDouble()*10;
   numberOfBoids = rng.nextInt(1000);
  }
}
