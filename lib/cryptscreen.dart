import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;


class cryptScreen extends StatefulWidget {
  @override
  _cryptScreenState createState() => _cryptScreenState();
}

class _cryptScreenState extends State<cryptScreen> {

  List currencies;
  List<MaterialColor> _colors = [Colors.yellow,Colors.blue,Colors.indigo,Colors.red];


  @override
  void initState() async {
    // TODO: implement initState
    super.initState();
    currencies = await getCurrencies();
  }

  Future<List> getCurrencies() async {
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(cryptoUrl);
    return JSON.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.brown,
        title: Text("eCapital",style: TextStyle(color: Colors.white30),),
        centerTitle: true,
        actions: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Icon(Icons.search)
            ],
          )
        ],
      ),
      body: _cryptoWidget(),
    );
  }
  Widget _cryptoWidget(){
    return new Flexible(
        child: new ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (BuildContext context, int index){
            final Map currency = currencies[index];
            final MaterialColor color = _colors[index * _colors.length];
            return _getListItemUi(currency,color);
          },
        ));
  }

  ListTile _getListItemUi(Map currency, MaterialColor color)
  {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name'],style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: _getSubtitleText(currency['price_usd'], currency['percent_change_1h']),
    );

  }

  Widget _getSubtitleText(String priceUSD, String percentageChange){
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n",style: TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;
    
    if(double.parse(percentageChange)>0){
      percentageChangeTextWidget = new TextSpan(text: percentageChange,
      style: TextStyle(color: Colors.green));
    }else{
      percentageChangeTextWidget = new TextSpan(text: percentageChangeText,
      style: TextStyle(color: Colors.red));
    }
  }
}
