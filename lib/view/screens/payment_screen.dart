import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:gradution_project/view/widgets/my_button.dart';
import 'package:gradution_project/controller/payment_provider.dart'; // Adjust path if necessary

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => PaymentProvider(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text("Checkout"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<PaymentProvider>(
              builder: (context, provider, _) {
                return Column(
                  children: [
                       CreditCardWidget(
                        padding: 0,
                        width : screenWidth*0.9,
                        height: screenHeight*0.3,
                        cardNumber: provider.cardNumber,
                        expiryDate: provider.expiryDate,
                        cardHolderName: provider.cardHolderName,
                        cvvCode: provider.cvvCode,
                        showBackView: provider.isCvvFocused,
                        onCreditCardWidgetChange: (p0) {},
                      ),
                    CreditCardForm(
                      formKey: provider.formKey,
                      cardNumber: provider.cardNumber,
                      expiryDate: provider.expiryDate,
                      cardHolderName: provider.cardHolderName,
                      cvvCode: provider.cvvCode,
                      onCreditCardModelChange: (data) {
                        provider.updateCardDetails(data);
                      },
                    ),
                  ],
                );
              },
            ),
            // Spacer(),
            MyButton(
              text: 'PaY nOw',
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
               },
            ),
           SizedBox(
              height: screenHeight*0.02,
            ),
          ],
        ),
      ),
    );
  }
}
