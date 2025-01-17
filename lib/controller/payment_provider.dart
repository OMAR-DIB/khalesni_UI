import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentProvider with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  // void updateCardDetails(CreditCardModel data) {
  //   cardNumber = data.cardNumber;
  //   expiryDate = data.expiryDate;
  //   cardHolderName = data.cardHolderName;
  //   cvvCode = data.cvvCode;
  //   notifyListeners();
  // }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
