class TodoModel {
  TodoModel(
      {required this.remark,
      required this.startDate,
      required this.endDate,
      required this.timeLeft,
      this.timeLeftinMinutes,
      required this.iscomplete});

  String remark;
  DateTime startDate;
  DateTime endDate;
  int? timeLeftinMinutes;
  String timeLeft;
  bool iscomplete;
}
