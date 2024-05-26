// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubscriptionModel {
  int? id;
  int? period;
  int? numberOfUsage;
  int? costInOneMonth;
  int? total;
  int? totalWithDiscount;
  SubscriptionModel({
    this.id,
    this.period,
    this.numberOfUsage,
    this.costInOneMonth,
    this.total,
    this.totalWithDiscount,
  });

  SubscriptionModel copyWith({
    int? id,
    int? period,
    int? number_of_usage,
    int? cost_in_one_month,
    int? total,
    int? total_with_discount,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      period: period ?? this.period,
      numberOfUsage: number_of_usage ?? numberOfUsage,
      costInOneMonth: cost_in_one_month ?? costInOneMonth,
      total: total ?? this.total,
      totalWithDiscount: total_with_discount ?? totalWithDiscount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'period': period,
      'number_of_usage': numberOfUsage,
      'cost_in_one_month': costInOneMonth,
      'total': total,
      'total_with_discount': totalWithDiscount,
    };
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      id: map['id'] != null ? map['id'] as int : null,
      period: map['period'] != null ? map['period'] as int : null,
      numberOfUsage:
          map['number_of_usage'] != null ? map['number_of_usage'] as int : null,
      costInOneMonth: map['cost_in_one_month'] != null
          ? map['cost_in_one_month'] as int
          : null,
      total: map['total'] != null ? map['total'] as int : null,
      totalWithDiscount: map['total_with_discount'] != null
          ? map['total_with_discount'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModel.fromJson(String source) =>
      SubscriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CouponOffersModel(id: $id, period: $period, number_of_usage: $numberOfUsage, cost_in_one_month: $costInOneMonth, total: $total, total_with_discount: $totalWithDiscount)';
  }

  @override
  bool operator ==(covariant SubscriptionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.period == period &&
        other.numberOfUsage == numberOfUsage &&
        other.costInOneMonth == costInOneMonth &&
        other.total == total &&
        other.totalWithDiscount == totalWithDiscount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        period.hashCode ^
        numberOfUsage.hashCode ^
        costInOneMonth.hashCode ^
        total.hashCode ^
        totalWithDiscount.hashCode;
  }
}
