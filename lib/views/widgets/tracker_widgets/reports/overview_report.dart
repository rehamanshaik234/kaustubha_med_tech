import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import '../../../../../../utils/app_colors/app_colors.dart';

class OverviewReportGraph extends StatelessWidget {
  const OverviewReportGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerProvider>(
      builder: (context, provider, child) {
        // Extract the monthly heartbeat and temperature data from the provider
        List<_ChartData> monthlyData = provider.tracker.overview?.report
            ?.map((data) => _ChartData(
          data.week ?? "",
          data.prevMonth ?? 0,
          data.thisMonth ?? 0,
        ))
            .toList() ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h,),
            Text('Overview Report',style: GoogleFonts.dmSans(fontSize: 20.sp,fontWeight: FontWeight.w600),),
            SizedBox(height: 12.h,),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(
                  labelStyle: TextStyle(fontSize: 8), // Set the font size for the X-axis labels
                  majorGridLines: MajorGridLines(width: 0), // Disable vertical grid lines
                ),
                primaryYAxis: const NumericAxis(
                  interval: 20,
                  maximum: 100,
                  majorGridLines: MajorGridLines(width: 1), // Enable horizontal grid lines
                ),
                series: <CartesianSeries>[
                  // Heartbeat Data
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: monthlyData,
                    xValueMapper: (_ChartData data, _) => data.week,
                    yValueMapper: (_ChartData data, _) => data.previousMonth,
                    gradient: LinearGradient(
                      colors: AppColors.blueColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.barGraphBlue1,
                    borderWidth: 2,
                    name: 'Previous Month',
                  ),
                  // Temperature Data
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: monthlyData,
                    xValueMapper: (_ChartData data, _) => data.week,
                    yValueMapper: (_ChartData data, _) => data.thisMonth,
                    gradient: LinearGradient(
                      colors: AppColors.greenColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.barGraphGreen1,
                    borderWidth: 2,
                    name: 'This Month',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SizedBox(width: 4.w,),
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            color: AppColors.barGraphGreen1,
                            borderRadius: BorderRadius.circular(4.w)
                        ),
                        child: Icon(Icons.bar_chart,color: Colors.white,size: 16.sp,),
                      ),
                      SizedBox(width: 8.w,),
                      Text("This Month",style: GoogleFonts.dmSans(color: Colors.black,fontSize: 16.sp),),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                            color: AppColors.barGraphBlue1,
                            borderRadius: BorderRadius.circular(4.w)
                        ),
                        child: Icon(Icons.bar_chart,color: Colors.white,size: 16.sp,),
                      ),
                      SizedBox(width: 8.w,),
                      Text("Previous Month",style: GoogleFonts.dmSans(color: Colors.black,fontSize: 16.sp),),
                    ],
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  double formatToTwoDecimalPlaces(num value) {
    return double.parse(value.toStringAsFixed(2));
  }
}

class _ChartData {
  _ChartData(this.week, this.previousMonth, this.thisMonth);

  final String week;
  final num previousMonth;
  final num thisMonth;
}
