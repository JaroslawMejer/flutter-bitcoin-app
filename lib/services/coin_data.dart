import 'networking.dart';

const bitcoinAverageUrl =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getCurrentValue(
      String cryptoCurrency, String currency) async {
    var url = '$bitcoinAverageUrl$cryptoCurrency$currency';
    print(url);
    NetworkHelper networkHelper = NetworkHelper(url);

    var currentValue = await networkHelper.getData();

    return currentValue;
  }
}
