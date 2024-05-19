// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:off_yaba/models/store_model.dart';

class StoreDetailsModel {
  StoreModel? store;
  List<WorkHour>? workHours;
  StoreDetailsModel({
    this.store,
    this.workHours,
  });

  StoreDetailsModel copyWith({
    StoreModel? store,
    List<WorkHour>? workHours,
  }) {
    return StoreDetailsModel(
      store: store ?? this.store,
      workHours: workHours ?? this.workHours,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'store': store?.toMap(),
      'workHours': workHours?.map((x) => x.toMap()).toList(),
    };
  }

  factory StoreDetailsModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> hours = map['work_hours'];
    return StoreDetailsModel(
      store: StoreModel.fromMap(map),
      workHours: map['work_hours'] != null
          ? hours.map((e) => WorkHour.fromMap(e)).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreDetailsModel.fromJson(String source) =>
      StoreDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StoreDetailsModel(store: $store, workHours: $workHours)';

  @override
  bool operator ==(covariant StoreDetailsModel other) {
    if (identical(this, other)) return true;

    return other.store == store && listEquals(other.workHours, workHours);
  }

  @override
  int get hashCode => store.hashCode ^ workHours.hashCode;
}

class WorkHour {
  int? id;
  String? day;
  String? start;
  String? end;
  WorkHour({
    this.id,
    this.day,
    this.start,
    this.end,
  });

  WorkHour copyWith({
    int? id,
    String? day,
    String? start,
    String? end,
  }) {
    return WorkHour(
      id: id ?? this.id,
      day: day ?? this.day,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'day': day,
      'start': start,
      'end': end,
    };
  }

  factory WorkHour.fromMap(Map<String, dynamic> map) {
    return WorkHour(
      id: map['id'] != null ? map['id'] as int : null,
      day: map['day'] != null ? map['day'] as String : null,
      start: map['start'] != null ? map['start'] as String : null,
      end: map['end'] != null ? map['end'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkHour.fromJson(String source) =>
      WorkHour.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WorkHour(id: $id, day: $day, start: $start, end: $end)';
  }

  @override
  bool operator ==(covariant WorkHour other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.day == day &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode {
    return id.hashCode ^ day.hashCode ^ start.hashCode ^ end.hashCode;
  }
}
