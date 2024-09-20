import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import '../../../../../../utils/app_colors/app_colors.dart';

class HeartBeatTemperatureDailyGraph extends StatelessWidget {
  const HeartBeatTemperatureDailyGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerProvider>(
      builder: (context, provider, child) {
        // Extract the monthly heartbeat and temperature data from the provider
        List<_ChartData> monthlyData = provider.tracker.healthMonitoring?.dailyMonitoring
            ?.map((data) => _ChartData(
          data.day ?? "",
          data.pulse ?? 0,
          data.temperature ?? 0,
        ))
            .toList() ?? [];
        final pulseValues = monthlyData.map((data) => data.pulse).toList();
        final temperatureValue = monthlyData.map((data) => data.temperature).toList();
        final avgPulse = pulseValues.isNotEmpty ? pulseValues.reduce((a, b) => a + b) / pulseValues.length : 0;
        final avgTemperature = temperatureValue.isNotEmpty ? temperatureValue.reduce((a, b) => a + b) / temperatureValue.length : 0;

        return Column(
          children: [
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(
                  labelStyle: TextStyle(fontSize: 8), // Set the font size for the X-axis labels
                  majorGridLines: MajorGridLines(width: 0), // Disable vertical grid lines
                ),
                primaryYAxis: const NumericAxis(
                  majorGridLines: MajorGridLines(width: 1), // Enable horizontal grid lines
                ),
                series: <CartesianSeries>[
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: monthlyData,
                    xValueMapper: (_ChartData data, _) => data.day,
                    yValueMapper: (_ChartData data, _) => data.temperature,
                    gradient: LinearGradient(
                      colors: AppColors.redColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.barGraphRed1,
                    borderWidth: 2,
                    name: 'Temperature',
                  ),
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: monthlyData,
                    xValueMapper: (_ChartData data, _) => data.day,
                    yValueMapper: (_ChartData data, _) => data.pulse,
                    gradient: LinearGradient(
                      colors: AppColors.blueColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.barGraphBlue1,
                    borderWidth: 2,
                    name: 'Heart Beat',
                  ),
                  // Temperature Data
                ],
                tooltipBehavior: TooltipBehavior(enable: true),
              ),
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 4.w,),
                      CircleAvatar(
                          radius: 20.sp,
                          backgroundColor: AppColors.barGraphBlue1.withOpacity(0.5),
                          child: Center(child: Icon(CupertinoIcons.heart,size: 25.sp,color: Colors.white,))),
                      SizedBox(width: 8.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Heart Beat",style: GoogleFonts.dmSans(color: Colors.black54),),
                          Text("${formatToTwoDecimalPlaces(avgPulse)} BPM",style: GoogleFonts.dmSans(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16.sp),)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 4.w,),
                      CircleAvatar(
                          radius: 20.sp,
                          backgroundColor: AppColors.barGraphRed1.withOpacity(0.5),
                          child: Center(child: Icon(CupertinoIcons.thermometer,size: 25.sp,color: Colors.white,))),
                      SizedBox(width: 8.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Temperature",style: GoogleFonts.dmSans(color: Colors.black54),),
                          Text("${formatToTwoDecimalPlaces(avgTemperature)}°C",style: GoogleFonts.dmSans(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16.sp),)
                        ],
                      )
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
  _ChartData(this.day, this.pulse, this.temperature);

  final String day;
  final num pulse;
  final num temperature;
}
