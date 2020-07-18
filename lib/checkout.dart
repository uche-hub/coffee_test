import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/cart.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = '/checkout';
  CheckOutScreen({Key key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<String> _methods = ['Paypal', 'Credit', 'Wallet'];
  static int _selectedPaymentMethodIndex = 1;
  bool _isSaveCardData = true;
  bool _isProcessing = false;
  PageController _methodController;

  @override
  void initState() {
    _methodController = PageController(
        viewportFraction: 1 / 3, initialPage: _selectedPaymentMethodIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Cart cart = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Payment data'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(114, 98, 230, .1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Total price',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '₦${cart.totalPrice}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color: Color.fromRGBO(114, 98, 230, 1),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(10)),
                      Text(
                        'Payment Method',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        height: 65,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          itemCount: _methods.length,
                          itemBuilder: (context, index) =>
                              _paymentMethods(context, index, _methods),
                          scrollDirection: Axis.horizontal,
                          controller: _methodController,
                          onPageChanged: (value) {},
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Card number',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      _creditCardInput('card_number', '**** **** **** ****'),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Valid until',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                _creditCardInput('card_exp', 'Month / Year'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'CVV',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                _creditCardInput('card_cvv', '***'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Text(
                        'Card holder',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      _creditCardInput('card_holder', 'Your name and surname'),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text('Save card data for future payments'),
                          ),
                          Switch(
                            value: _isSaveCardData,
                            onChanged: (value) {
                              setState(() {
                                _isSaveCardData = value;
                              });
                            },
                            activeColor: Colors.deepPurple.shade300,
                            activeTrackColor: Colors.deepPurpleAccent,
                          ),
                        ],
                      ),
                      _flatButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentMethods(context, index, _methods) {
    String method = _methods[index];
    //Color.fromRGBO(114, 98, 230, 1),
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethodIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _selectedPaymentMethodIndex == index
              ? Color.fromRGBO(114, 98, 230, 1)
              : Color.fromRGBO(114, 98, 230, .4),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: _selectedPaymentMethodIndex == index
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 6,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]
              : [],
        ),
        margin: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              method + ' ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
              ),
            ),
            Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Container _creditCardInput(type, labelText) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white12, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          type == 'card_number'
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Image.asset('images/mastercard.png'),
                )
              : Container(),
          Expanded(
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  labelText: labelText,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 16, left: 8)),
              keyboardType: type == 'card_holder'
                  ? TextInputType.text
                  : TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Widget _flatButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      height: 70,
      child: FlatButton(
        onPressed: () {},
        child: Center(
          child: Text(
            "Proceed to Checkout",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        color: Color.fromRGBO(114, 98, 230, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
