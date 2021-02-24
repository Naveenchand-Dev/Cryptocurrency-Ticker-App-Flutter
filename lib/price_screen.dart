import 'dart:io';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  bool isLoading = true;

  String selectedCurrency = 'INR';
  Map<String, String> coinDatas = {};

  void getData() async {
    CoinData coinData = CoinData();
    Map<String, String> result = await coinData.getCoinData(selectedCurrency);
    setState(() {
      coinDatas = result;
      isLoading = false;
    });
  }

  DropdownButton androidMenu() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }
    return DropdownButton(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          isLoading = true;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text(currency, style: TextStyle(color: Colors.white)));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          getData();
        });
      },
      children: pickerList,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardStyle(
                    label: '1 BTC',
                    value: isLoading ? '? ' : coinDatas['BTC'],
                    currency: selectedCurrency,
                  ),
                  CardStyle(
                    label: '1 ETH',
                    value: isLoading ? '? ' : coinDatas['ETH'],
                    currency: selectedCurrency,
                  ),
                  CardStyle(
                    label: '1 LTC',
                    value: isLoading ? '? ' : coinDatas['LTC'],
                    currency: selectedCurrency,
                  ),
                ],
              )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blue[800],
            child: Platform.isIOS ? iosPicker() : androidMenu(),
          ),
        ],
      ),
    );
  }
}

class CardStyle extends StatelessWidget {
  final String label;
  final String value;
  final String currency;
  CardStyle({this.label, this.value, this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '$label = $value $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
