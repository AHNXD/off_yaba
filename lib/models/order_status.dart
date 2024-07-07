// order_status.dart

enum OrderStatus {
  pendingConfirmation,
  confirmed,
  canceled,
  inTransit,
}

String getOrderStatusString(OrderStatus status) {
  switch (status) {
    case OrderStatus.pendingConfirmation:
      return 'يتم تأكيد الطلب';
    case OrderStatus.confirmed:
      return 'تم تأكيد الطلب';
    case OrderStatus.canceled:
      return 'تم إلغاء الطلب';
    case OrderStatus.inTransit:
      return 'يتم إيصال الطلب';
  }
}

OrderStatus getOrderStatusFromString(String status) {
  switch (status) {
    case 'يتم تأكيد الطلب':
      return OrderStatus.pendingConfirmation;
    case 'تم تأكيد الطلب':
      return OrderStatus.confirmed;
    case 'تم إلغاء الطلب':
      return OrderStatus.canceled;
    case 'يتم إيصال الطلب':
      return OrderStatus.inTransit;
    default:
      throw ArgumentError('Invalid order status: $status');
  }
}
