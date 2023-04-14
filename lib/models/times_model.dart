import 'dart:convert';

class TimesModel {
  List<String> dates;
  List<Map<String,bool>> times;

  TimesModel({required this.dates, required this.times});

  TimesModel toMap(){
    return TimesModel(dates: dates, times: times);
  }

  factory TimesModel.fromMap(Map<String, dynamic> map){
    List<Map<String, bool>> list = [];
    Map<String, bool> tempMap = {};
    for(var date in map.keys){
      tempMap = Map.from(map[date]);
      Map<String,bool> newmap = {};
      for (String _key in tempMap.keys.toList().reversed) {
        newmap[_key] = tempMap[_key]!;
      }
      list.add(newmap);
    }
    return TimesModel(dates: map.keys.toList(), times: list);
  }
}