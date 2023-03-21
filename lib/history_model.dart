class HistoryModel {
  List<String> names;
  List<String> addresses;
  List<String> dates;
  List<String> times;

  HistoryModel({
    required this.names,
    required this.addresses,
    required this.dates,
    required this.times,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> map){
     return HistoryModel(
      names: map['names'],
      addresses: map['addresses'],
      dates: map['dates'],
      times: map['times'],
      );
  }

  Map<String, dynamic> toMap() {
    return {
      "names": names,
      "addresses": addresses,
      "dates": dates,
      "times": times,
    };
  }
}

