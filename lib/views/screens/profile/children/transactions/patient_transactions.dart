import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/transactions/transactions.dart';
import 'package:kaustubha_medtech/models/transactions/TransactionModel.dart';
import 'package:kaustubha_medtech/views/alerts/custom_alerts.dart';
import 'package:kaustubha_medtech/views/widgets/transactions/activity_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../../../controller/localdb/local_db.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../widgets/review_card.dart';
class PatientTransactionsScreen extends StatefulWidget {
  const PatientTransactionsScreen({super.key});

  @override
  State<PatientTransactionsScreen> createState() => _PatientTransactionsScreenState();
}

class _PatientTransactionsScreenState extends State<PatientTransactionsScreen> {
  String selectedDate=DateTime.now().toString();
  int selectedTab=1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      getTransactions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBgColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        title: Text('Transactions', style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 20.sp),),
      ),
      body: Consumer<TransactionsProvider>(
          builder: (context,provider,_){
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Constants.dateConverted(selectedDate),style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 14.sp),),
                        TransactionDateDropdown(onChange: (val){
                          if(val==3){
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.parse(selectedDate), // Set the initial date to today
                              firstDate: DateTime(2024,10,22),    // Set the earliest selectable date to today
                              lastDate: DateTime.now(), // Set the last selectable date
                            ).then((date) {
                              if (date != null) {
                                selectedDate=date.toString();
                                selectedTab=val;
                                setState(() {});
                                getTransactions();
                              }
                            });
                          }
                         else if(val==1){
                            selectedDate=DateTime.now().toString();
                            selectedTab=val;
                            setState(() {});
                            getTransactions();
                          }
                         else if(val==2){
                            selectedDate=DateTime.now().subtract(Duration(days: 1)).toString();
                            selectedTab=val;
                            setState(() {});
                            getTransactions();
                          }
                        }, selectedTab: selectedTab,selectedValue: selectedDate,)
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  if(provider.loader)
                    SizedBox(
                        height: 1.sh*0.7,
                        child: Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black,strokeWidth: 2.sp,))),
                  if(provider.transactions.isEmpty && !provider.loader)
                     SizedBox(
                         height: 1.sh*0.7,
                         child: Center(child: Text('No Transactions Found',style: GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),)),
              
                  Visibility(
                    visible: !provider.loader && provider.transactions.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // This makes the Column take only needed space
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: (1.sw / 4) - 16,
                                      child: const Center(
                                          child: Text(
                                            'Payment ID',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ))),
                                  SizedBox(
                                      width: (1.sw / 4) - 16,
                                      child: const Center(
                                          child: Text(
                                            'Date',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ))),
                                  SizedBox(
                                      width: (1.sw / 4) - 16,
                                      child: const Center(
                                          child: Text(
                                            'Amount',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ))),
                                  SizedBox(
                                      width: (1.sw / 4) - 16,
                                      child: const Center(
                                          child: Text(
                                            'Status',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ))),
                                ],
                              ),
                            ),
                            const Divider(),
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside the ListView
                              itemCount: provider.transactions.length,
                              itemBuilder: (context, index) {
                                TransactionModel transaction = provider.transactions[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: (1.sw / 4) - 16,
                                        child: Center(
                                          child: Text(
                                            transaction.paymentId ?? 'N/A',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.dmSans(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (1.sw / 4) - 16,
                                        child: Center(
                                          child: Text(
                                            Constants.dateConvertedTransaction(transaction.createdAt ?? DateTime.now().toString()),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (1.sw / 4) - 16,
                                        child: Center(
                                          child: Text(
                                            transaction.amount != null ? '₹${transaction.amount}' : '₹0',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (1.sw / 4) - 16,
                                        child: Center(
                                          child: Text(
                                            transaction.paymentStatus ?? 'N/A',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(
                                              fontSize: 16,
                                              color: transaction.paymentStatus == 'success' ? Colors.green : Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void getTransactions(){
    context.read<TransactionsProvider>().getPatientTransactions((r){},date: selectedDate);
  }
}
