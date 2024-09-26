import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/controller/providers/patient/patient_home.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:kaustubha_medtech/utils/routes/route_names/route_names.dart';
import 'package:kaustubha_medtech/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';
class PatientDocumentCard extends StatefulWidget {
  const PatientDocumentCard({super.key});

  @override
  State<PatientDocumentCard> createState() => _PatientDocumentCardState();
}

class _PatientDocumentCardState extends State<PatientDocumentCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PatientHomeProvider>(
        builder: (context,provider,child){
          if(provider.patientDocumentsModel.userId==null) {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.info,color: Colors.redAccent,),
                          SizedBox(width: 4.w,),
                          Text('Documents Not uploaded', style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w500, fontSize: 16.sp),),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 80.w,
                        child: CustomButton(onPressed: ()=>Navigator.of(context,rootNavigator: true).pushNamed(RoutesName.patientDocuments), title: "Upload",textSize: 12.sp,padding: 0,))
                  ],
                ),
              ),
            );
          }
          return SizedBox(width: 0,height: 0,);
        });
  }
}
