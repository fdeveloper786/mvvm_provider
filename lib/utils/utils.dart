import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Utils{

  /// average rating
  static double averageRating(List<int> rating){
    var avgRating = 0;
    for(int i = 0; i<rating.length;i++){
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating/rating.length).toStringAsFixed(1));
  }

  /// Custom Toast Message
    static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  }

  /// Custom FlushBar
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeOut,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          borderRadius: BorderRadius.circular(8),
          icon: const Icon(Icons.error),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(10),
          message: message,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        )..show(context));
  }

  /// SnackBar
  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  /// Text-field focus change
  static void fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus
      ){
      current.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
  }
}