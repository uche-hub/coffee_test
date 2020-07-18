import 'package:flutter/material.dart';
import 'package:flutterapp/checkout.dart';

import 'models/cart.dart';
import 'models/coffee.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  int _selectedPosition = -1;
  int _coffeePrice = 0;
  int _cupsCounter = 0;
  int price = 0;
  String _currency = "₦";

  String _coffeeCupImage = "images/coffee_cup_size.png";
  Coffee _coffee;
  Cart _cart;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _coffee = ModalRoute.of(context).settings.arguments;
    print('build selected size @ $_coffeePrice');
    _cart = Cart(totalPrice: price);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: FlatButton(
              onPressed: () {
                _confirmOrderModalBottomSheet(
                    totalPrice: "$_currency$price",
                    numOfCups: "x $_cupsCounter");
              },
              child: Text(
                "Buy Now",
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue))),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  this.price = 0;
                  this._cupsCounter = 0;
                });
              },
              child: Icon(Icons.clear),
            ),
            Container(
              height: double.maxFinite,
              alignment: Alignment.center,
              child: Text(
                "$_cupsCounter Cups = $_currency$price.00",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
        body: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: _mainBody(),
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Widget _mainBody() {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 0,
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 150,
                  margin:
                      EdgeInsets.only(left: 50, right: 50, bottom: 50, top: 60),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(180)),
                      color: Color.fromRGBO(239, 235, 233, 100)),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  height: 300,
                  child: Image.asset(
                    _coffee.url, //image url passed
                    height: 250,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          Expanded(
              flex: 0,
              child: Text(
                _coffee.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
          Padding(
            padding: EdgeInsets.all(6),
          ),
          Expanded(
            flex: 0,
            child: Text(
              "Select the cup size you want and we will deliver it to you in less than 48hours",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black45,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 20),
            height: 55,
            width: double.maxFinite,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  child: RichText(
                    textDirection: TextDirection.ltr,
                    text: TextSpan(
                        text: _currency,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black87),
                        children: [
                          TextSpan(
                            text: '$_coffeePrice',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: _coffeeSizeButton(_selectedPosition == index,
                          index == 0 ? "S" : index == 1 ? "M" : "L"),
                      onTap: () {
                        setState(() {
                          _coffeePrice = index == 0
                              ? _coffee.price
                              : index == 1
                                  ? _coffee.price * 2
                                  : _coffee.price * 3;
                          _selectedPosition = index;
                        });
                      },
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  shrinkWrap: true,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            curve: Curves.bounceIn,
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            height: 70,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  this._cupsCounter += 1;
                  this.price += _coffeePrice;
                });
                Duration time = Duration(milliseconds: 150);
                Future.delayed(time, (){
                  setState(() {

                  });
                });

              },
              child: Center(
                child: Text(
                  "Add to Bag",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _coffeeSizeButton(bool isSelected, String coffeeSize) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: 55,
          child: Text(
            coffeeSize,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.black45),
          ),
        ),
        new Container(
          margin: EdgeInsets.only(right: 10),
          child: Image.asset(
            _coffeeCupImage,
            width: 50,
            color: isSelected ? Colors.blue : Colors.black45,
          ),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: isSelected ? Colors.blue : Colors.black45,
                    width: isSelected ? 2 : 1),
                left: BorderSide(
                    color: isSelected ? Colors.blue : Colors.black45,
                    width: isSelected ? 2 : 1),
                bottom: BorderSide(
                    color: isSelected ? Colors.blue : Colors.black45,
                    width: isSelected ? 2 : 1),
                right: BorderSide(
                    color: isSelected ? Colors.blue : Colors.black45,
                    width: isSelected ? 2 : 1)),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        )
      ],
    );
  }

//  Widget get _animatedButtonUi => Container(
//    height: 70.0,
//    width: 200,
//    decoration: ,
//  );

  void _confirmOrderModalBottomSheet({String totalPrice, String numOfCups}) {
    var scale = 1- _controller.value;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 250.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
              padding: EdgeInsets.all(10),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Confirm Order",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(),
                  ),
                  _getEstimate(totalPrice, numOfCups),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.all(10),
                    width: 200,
                    height: 70,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          CheckOutScreen.routeName,
                          arguments: _cart,
                        );
                      },
                      child: GestureDetector(
                        onTapDown: OnTapDown,
                        onTapUp: OnTapUp,
                        onTapCancel: OnTapCancel,
                        child: Transform.scale(
                          scale: scale,
                          child: Center(
                            child: Text(
                              "Proceed to Checkout",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  OnTapDown(TapDownDetails details){
    _controller.forward();
  }
  OnTapUp(TapUpDetails details){
    _controller.reverse();
  }
  OnTapCancel(){
    _controller.reverse();
  }

  Widget _getEstimate(String totalPrice, String numOfCups) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "images/cup_of_coffee.png",
          height: 70,
          width: 50,
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text(
          numOfCups,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(10)),
        Text(
          totalPrice,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
