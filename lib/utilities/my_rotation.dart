import 'dart:math';
import 'dart:ui';

class MyRotation{
  static Offset rotate(Offset point, Offset center, double angle){
    double s = sin(angle);
    double c = cos(angle);

    // translate point back to origin:
    point = point - center;

    // rotate point
    double xnew = point.dx * c - point.dy * s;
    double ynew = point.dx * s + point.dy * c;

    // translate point back:
    point = Offset(xnew + center.dx, ynew + center.dy);
    return point;
  }
}