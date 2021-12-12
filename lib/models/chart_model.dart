class ChartModel{
  String? price;
  DateTime? dateTime;

  ChartModel(this.price, this.dateTime);

  @override
  String toString() {
    return 'ChartModel{price: $price, dateTime: $dateTime}';
  }
}