import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressBarProvider extends ChangeNotifier {

  double prog = 0.0;

  setProg(double pro){

    prog = pro;
  }



}