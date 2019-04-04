import 'package:flutter/material.dart';
import 'package:vcrypto/cryptscreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      theme: ThemeData(
        primarySwatch: Colors.brown
      ),
      routes: <String,WidgetBuilder>{
        '/cryptScreen': (BuildContext context) => new cryptScreen(),
      },
    );
  }
}

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iconAnimationController = new AnimationController(vsync: this,
    duration: new Duration(seconds: 2));

    _iconAnimation = new Tween(
        begin: 250.0, end: 40.0).animate(
        new CurvedAnimation(
            parent: _iconAnimationController,
            curve: new Interval(0.0,0.700)));
    _iconAnimation.addListener(()=>this.setState((){}));
    _iconAnimationController.forward();

    _iconAnimationController.addListener((){
      if(_iconAnimationController.isCompleted){
        Navigator.of(context).pushNamed('/cryptScreen');
      }
    });
  }

  Future<Null> _playAnimation() async{
    try{
      await _iconAnimationController.forward();
      await _iconAnimationController.reverse();
    }
    on TickerCanceled{}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: new Center(
        child: new Container(
          padding: EdgeInsets.all(3.0),
          height: 40.0,
          width: _iconAnimation.value,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white30),
          child: _iconAnimation.value> 135.0 ? new Row(
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(left: 10.0)),
              new Icon(Icons.arrow_forward,size: 0.09*_iconAnimation.value,),
//              new Padding(
//                  padding: EdgeInsets.only(left: 10.0)),
//              new Container(
//                width: 2.0,
//                height: 30.0,
//                color: Colors.black54,
//              ),
              new Padding(
                  padding: EdgeInsets.only(left: 15.0)),
              new InkWell(
                child: Text("Welcome User",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 0.09*_iconAnimation.value),
                ),
              onTap: (){
                  _playAnimation();
                 // Navigator.of(context).pushNamed('/cryptScreen');
              },)
            ],
          ) : new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Colors.black
            ),
          ),
        ),
      ),
    );
  }
}

