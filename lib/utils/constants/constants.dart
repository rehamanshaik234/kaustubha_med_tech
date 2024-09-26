import 'package:intl/intl.dart';

class Constants{
  static RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  static bool isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  static String patientRole='USER';


  static String dateConverted(String date){
    final converted=DateFormat('d MMM y').format(DateTime.parse(date));
    return converted;
  }
}