// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookingModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map json) => BookingModel(
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      bookingStart: BookingModel._dateTimeFromTimestamp(
          json['bookingStart'] as Timestamp),
      bookingEnd:
          BookingModel._dateTimeFromTimestamp(json['bookingEnd'] as Timestamp),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      washName: json['washName'] as String?,
      bookedTime:
          BookingModel._dateTimeFromTimestamp(json['bookedTime'] as Timestamp),
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'bookedTime': BookingModel._dateTimeAsIs(instance.bookedTime),
      'bookingStart': BookingModel._dateTimeAsIs(instance.bookingStart),
      'bookingEnd': BookingModel._dateTimeAsIs(instance.bookingEnd),
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'washName': instance.washName,
    };
