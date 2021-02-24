import 'package:http/http.dart' as http;
import 'dart:convert';

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

const coinapi = 'https://rest.coinapi.io/v1/exchangerate';

const apiKey = 'F1D23663-4B56-486D-9920-395377E3F170';

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoPrizes = {};

    for (String crypto in cryptoList) {
      http.Response response =
          await http.get('$coinapi/$crypto/$currency?apikey=$apiKey');
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var prize = data['rate'].toStringAsFixed(0);
        cryptoPrizes[crypto] = prize;
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrizes;
  }
}
