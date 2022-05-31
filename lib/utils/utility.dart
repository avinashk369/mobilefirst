import 'package:intl/intl.dart';

class Utility {
  static String getElapsedTime(int etime, int elapseTime) {
    //protocol time - elapsed time

    return printDurationHMS(Duration(seconds: etime - elapseTime));
  }

  static int getElapsedHour(int etime, int elapseTime) {
    //protocol time - elapsed time
    var mins = etime - elapseTime;

    var min = Duration(seconds: mins).inMinutes;

    return min ~/ 60;
  }

  static String totalTimeLeft(int elapseTime) {
    return Utility.printDurationHM(Duration(seconds: elapseTime));
  }

  static int getScDiffFromDates(DateTime dbDate) {
    int diff = 0;
    diff = DateTime.now().difference(dbDate).inSeconds;
    return diff;
  }

  static int elapsedHr(var etime, var elapseTime) {
    var mins = etime - elapseTime;

    var min = Duration(seconds: mins).inMinutes;
    //print("${seconds} total seconds");
    final int hour = min ~/ 60;

    return hour;
  }

  static DateTime generateDateTimeFromString(String startDateTime) {
    DateFormat format = DateFormat("yyyy-MM-dd kk:mm:ss");

    return format.parse(startDateTime);
  }

  static String getStartDate(String startDateTime) {
    DateFormat format = DateFormat("yyyy-MM-dd kk:mm:ss");

    String startDate = format.parse(startDateTime).toString().substring(0, 10);
    //print("${startDate} startdate");
    return startDate;
  }

  static String generateStartTime(DateTime startTIme) {
    DateTime newDate = startTIme.add(Duration(hours: 1));

    String formattedTime = DateFormat.Hms().format(newDate);

    return formattedTime.substring(0, formattedTime.length - 3);
  }

  static String generateEndTime(DateTime startTIme, String hours) {
    DateTime newDate = startTIme.add(Duration(hours: int.parse(hours) + 1));

    String formattedTime = DateFormat.Hms().format(newDate);

    return formattedTime.substring(0, formattedTime.length - 3);
  }

  static String getEndDate(DateTime startDateTime, String hours) {
    DateTime newDate = startDateTime.add(Duration(hours: int.parse(hours)));

    String endDate = newDate.toString().substring(0, 10);

    return endDate;
  }

  static String printDurationHMS(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}h:${twoDigitMinutes}m:${twoDigitSeconds}s";
  }

  static String printDurationHM(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    //String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}h:${twoDigitMinutes}m";
  }

  // static void showWebColoredToast(String message, Color color) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     backgroundColor: color,
  //     textColor: Colors.black,
  //     timeInSecForIosWeb: 5,
  //   );
  // }

  static int getTimeDifference(DateTime cTime, DateTime bgTime) {
    int diff = 0;
    print("${cTime} current time ${bgTime} bg time");
    return diff;
  }
}
