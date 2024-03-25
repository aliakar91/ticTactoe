import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppMediaQuery {
  static height(double value, BuildContext context) =>
      (MediaQuery.of(context).size.height * value).h;

  static width(double value, BuildContext context) =>
      MediaQuery.of(context).size.width * value;
}
