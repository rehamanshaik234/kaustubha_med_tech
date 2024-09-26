import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/views/widgets/consult_widgets/payment_fileds.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:kaustubha_medtech/views/widgets/custom_textfield.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../alerts/book_appointment.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay razorpay= Razorpay();

  var options = {
    'key': 'rzp_live_xbjNNeHZVe01E7',
    'amount': 500,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'prefill': {
      'contact': '8888888888',
      'email': 'test@razorpay.com'
    }
  };

  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: InkWell(onTap: ()=>Navigator.pop(context), child: Icon(Icons.arrow_back,color: Colors.white,size: 20.sp,)),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: 150.h,
            color: AppColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('120.00\$',style: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 30.sp),),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(20.sp),topRight: Radius.circular(20.sp)),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Doctor Channeling Payment Method',style:  GoogleFonts.dmSans(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16.sp),),
                    SizedBox(height: 16.h,),
                    CustomButton(onPressed: (){}, title: "Card Payment",width: 200,titleStyle: GoogleFonts.dmSans(color: Colors.white,fontSize: 14.sp),),
                    SizedBox(height: 16.h,),
                    PaymentFields(title: "Card Number", hint: "Enter Number", textEditingController: TextEditingController()),
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PaymentFields(title: "Expiry Date", hint: "Enter Date", textEditingController: TextEditingController(),width: 1.sw*0.5,),
                        PaymentFields(title: "CVV", hint: "Enter CVV", textEditingController: TextEditingController(),width: 1.sw*0.4,),

                      ],
                    ),
                    SizedBox(height: 16.h,),
                    PaymentFields(title: "Name", hint: "Enter Name", textEditingController: TextEditingController()),
                    SizedBox(height: 16.h,),
                    CustomButton(onPressed: (){
                      razorpay.open(options);
                      // AppointmentAlert.showBookedAppointment(context);
                    }, title: "Pay Now"),
                    SizedBox(height: 16.h,),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }


}
