import 'dart:math';

class CalculatorBrain {
  CalculatorBrain({
    required this.height1,
    required this.weight1,
  });
  final int height1;
  final int weight1;
  double bmi = 0;
  String calculateBmi() {
    bmi = weight1 / pow(height1 / 100, 2);
    return bmi.toStringAsFixed(1);
  }

  double _calcuBmi() {
    bmi = weight1 / pow(height1 / 100, 2);
    return bmi;
  }

//ToDo: Fix problem at the result if .HasanMhd.
  String getResults() {
    if (_calcuBmi() >= 25) {
      return 'OVERWEIGHT';
    } else if (_calcuBmi() > 18.5) {
      return 'NORMAL';
    } else {
      return 'UNDERWEIGHT';
    }
  }

  String getinterpretetaion() {
    if (_calcuBmi() >= 25) {
      return 'You have a higher than Normal body weight. Try to EXERCISE more. ';
    } else if (_calcuBmi() > 18.5) {
      return 'You have a Normal Body Weight .Good job!';
    } else {
      return 'You have a lower than normal body weight.you have to eat more!';
    }
  }
}
