import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/constants/constants.dart';
class AvailableTimes extends StatelessWidget {
  int index;
  List<String> sessions;
  Function(int) onAdd;
  Function(int) remove;

  AvailableTimes({super.key,required this.index,required this.sessions,required this.onAdd ,required this.remove });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Time',style:  GoogleFonts.dmSans(fontWeight: FontWeight.w500,fontSize: 16.sp),),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            for(int i=index;i<Constants.timings.length;i++)
              SizedBox(
                width: 82.w,
                child: FittedBox(
                  child: Row(
                    children: [
                      Checkbox(value: sessions.contains(Constants.timings[i]), onChanged: (val){
                        if(val==true){
                          onAdd(i);
                        }else{
                          remove(i);
                        }
                      },),
                      Text(Constants.timings[i],style: GoogleFonts.dmSans(),),
                    ],
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
