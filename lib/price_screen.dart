import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'services/coin_data.dart';
import 'dart:io'
    show Platform; // REQUIRED TO CHECK WHAT KIND OF SYSTEM USER IS USING

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcValue = 'btc';
  String ethValue = 'eth';
  String ltcValue = 'ltc';
  CoinData data = CoinData();

  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    var btcInfo = await data.getCurrentValue('btc', selectedCurrency);
    var ethInfo = await data.getCurrentValue('eth', selectedCurrency);
    var ltcInfo = await data.getCurrentValue('ltc', selectedCurrency);

    setState(() {
      btcValue = btcInfo['last'].round().toString();
      ethValue = ethInfo['last'].round().toString();
      ltcValue = ltcInfo['last'].round().toString();
    });
  }

  List<Card> listOfCrypto() {
    List<Card> allCryptos = [];

    String rightValue = '?';
    int iteration = 0;

    for (String crypto in cryptoList) {
      if (iteration == 0) {
        rightValue = btcValue;
      } else if (iteration == 1) {
        rightValue = ethValue;
      } else {
        rightValue = ltcValue;
      }
      var newItem = Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $rightValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
      iteration++;
      allCryptos.add(newItem);
    }

    return allCryptos;
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        updateUI();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = selectedIndex.toString();
        });
        updateUI();
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              children: listOfCrypto(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
