import 'dart:io';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class FileViewerModal{
  static void showNetworkFilePopUp(BuildContext context,String filePath){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
          return Stack(
            children: [
              Container(
                  height: 1.sh,
                  width: 1.sw,
                  decoration:  const BoxDecoration(
                      color: Colors.white
                  ),
                  child:filePath.endsWith('.pdf')?SfPdfViewer.network(filePath):Image.network(filePath,fit: BoxFit.fitWidth,)),
              Positioned(
                  top: 50.h,
                  right: 20.w,
                  child: InkWell(onTap: ()=>Navigator.pop(context), child:
                  CircleAvatar(
                      radius: 15.sp,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.close,color: Colors.white,size: 20.sp,)))),
            ],
          );
        });
  }
  static void showLocalFilePopUp(BuildContext context,String filePath){
    print(filePath);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
          return Stack(
            children: [
              Container(
                  height: 1.sh,
                  width: 1.sw,
                  decoration:  const BoxDecoration(
                      color: Colors.white
                  ),
                  child:filePath.endsWith('.pdf')?SfPdfViewer.file(File(filePath)):Image.file(File(filePath),fit: BoxFit.fitWidth,)),
              Positioned(
                  top: 50.h,
                  right: 20.w,
                  child: InkWell(onTap: ()=>Navigator.pop(context), child:
                  CircleAvatar(
                      radius: 15.sp,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.close,color: Colors.white,size: 20.sp,)))),
            ],
          );
        });
  }

  static void showMultipleNetworkFilePopUp(BuildContext context,String filePath1,String filePath2){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
          int currentDoc=0;
          return Stack(
            children: [
              StatefulBuilder(
                builder: (context,setState) {
                  return Container(
                      height: 1.sh,
                      width: 1.sw,
                      decoration:  const BoxDecoration(
                          color: Colors.white
                      ),
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.h,),
                          CustomSlidingSegmentedControl(
                              children: {
                            0:Text("Document 1",style: GoogleFonts.dmSans(color: currentDoc==0?Colors.white:Colors.black,fontWeight: FontWeight.w500),),
                            1:Text("Document 2",style: GoogleFonts.dmSans(color: currentDoc==1?Colors.white:Colors.black,fontWeight: FontWeight.w500))
                          },
                              initialValue: currentDoc,
                              thumbDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                color: AppColors.primaryColor
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  color: AppColors.scaffoldBgColor
                              ),
                              onValueChanged: (val){
                               currentDoc=val;
                               setState((){});
                              }),
                         currentDoc==0? Expanded(
                              child: filePath1.endsWith('.pdf')?SfPdfViewer.network(filePath1):Image.network(filePath1,fit: BoxFit.fitWidth,))
                         : Expanded(
                              child: filePath2.endsWith('.pdf')?SfPdfViewer.network(filePath2):Image.network(filePath2,fit: BoxFit.fitWidth,)),
                        ],
                      ));
                }
              ),
              Positioned(
                  top: 55.h,
                  right: 20.w,
                  child: InkWell(onTap: ()=>Navigator.pop(context), child:
                  CircleAvatar(
                      radius: 15.sp,
                      backgroundColor: Colors.black,
                      child: Icon(Icons.close,color: Colors.white,size: 20.sp,)))),
            ],
          );
        });
  }

}