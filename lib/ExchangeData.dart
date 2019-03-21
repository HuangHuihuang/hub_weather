
class ExchangeData {
  String exchange;  // 港币对人民币的汇率

  ExchangeData({this.exchange});

  factory ExchangeData.fromJson(Map<String, dynamic> json) {
    var cny = json['rates']['CNY'];
    var hkd = json['rates']['HKD'];

    print("cny:$cny, hkd:$hkd");

    var rate = cny / hkd;
    return ExchangeData(
        exchange: "汇率: " + rate.toStringAsFixed(4));
  }

  factory ExchangeData.empty() {
    return ExchangeData( exchange: "" );
  }
}