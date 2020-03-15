// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-detail.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class PaymentMethodListTile extends HookWidget {
  const PaymentMethodListTile(this.method, this.trailing, {Key key})
      : super(key: key);

  final PaymentMethod method;

  final Widget trailing;

  @override
  Widget build(BuildContext _context) =>
      paymentMethodListTile(method, trailing);
}

class CarListTile extends HookWidget {
  const CarListTile(this.car, this.trailing, {Key key}) : super(key: key);

  final CarModel car;

  final IconButton trailing;

  @override
  Widget build(BuildContext _context) => carListTile(car, trailing);
}
