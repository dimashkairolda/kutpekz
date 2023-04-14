import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookingModel.g.dart';

@JsonSerializable(anyMap: true)
class BookingModel {
  final String? userId;
  final String? userName;

  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  final DateTime bookedTime;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  final DateTime bookingStart;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
  final DateTime bookingEnd;

  final String? phoneNumber;
  final String? address;
  final String? washName;

  static DateTime _dateTimeAsIs(DateTime dateTime) => dateTime;

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) {
    return timestamp.toDate().add(Duration(hours: 6));
  }

  BookingModel(
      {
        this.phoneNumber,
        this.address,
        required this.bookingStart,
        required this.bookingEnd,
        this.userId,
        this.userName,
        this.washName,
        required this.bookedTime,
      });

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}