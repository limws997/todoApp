
//Time left checker, to check time dif between start date and end date
int timesleftchecker(DateTime startDate, DateTime endDate) {
  return endDate.difference(startDate).inMinutes;
}

//To return time left in string type, for display purpose
String timeleftstringchecker(int timeLeftInMinutes) {
  int hourLeft = ((timeLeftInMinutes - (timeLeftInMinutes % 60)) / 60).toInt();
  int minutesLeft = (timeLeftInMinutes % 60).toInt();
  String timeLeftInString =
      '${hourLeft.toString()} hrs ${minutesLeft.toString()} min ';
  return timeLeftInString;
}
