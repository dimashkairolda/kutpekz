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
      names: List<String>.from(map['names']),
      addresses: List<String>.from(map['addresses']),
      dates: List<String>.from(map['dates']),
      times: List<String>.from(map['times']),
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

