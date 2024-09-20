import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../tracker_average_widget.dart';

class TrackerTemperatureWeeklyGraph extends StatefulWidget {
  const TrackerTemperatureWeeklyGraph({super.key});

  @override
  State<TrackerTemperatureWeeklyGraph> createState() => _TrackerTemperatureWeeklyGraphState();
}

class _TrackerTemperatureWeeklyGraphState extends State<TrackerTemperatureWeeklyGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerProvider>(
      builder: (context, provider, child) {
        // Extract the weekly temperature data from the provider
        List<_ChartData> weeklyTemperatureData = provider.tracker.healthMonitoring?.weeklyMonitoring
            ?.map((data) => _ChartData(data.week ?? "", data.temperature ?? 0.0))
            .toList() ??
            [];

        final pulseValues = weeklyTemperatureData.map((data) => data.temperature).toList();
        final minPulse = pulseValues.isNotEmpty ? pulseValues.reduce((a, b) => a < b ? a : b) : 0;
        final maxPulse = pulseValues.isNotEmpty ? pulseValues.reduce((a, b) => a > b ? a : b) : 0;
        final avgPulse = pulseValues.isNotEmpty ? pulseValues.reduce((a, b) => a + b) / pulseValues.length : 0;

        return Column(
          children: [
            SizedBox(
              height: 250.h,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(fontSize: 12.sp),
                  majorGridLines: const MajorGridLines(width: 0), // Disable vertical grid lines
                ),
                primaryYAxis: NumericAxis(
                  interval: 5, // Set the Y-axis interval to 5 degrees
                  majorGridLines: const MajorGridLines(width: 1), // Enable horizontal grid lines
                  minimum: 80, // Start the Y-axis from 80 degrees
                  maximum: 105, // Adjust the maximum based on temperature range
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    Color labelColor;

                    // Custom logic to change label color based on value
                    if (details.value <= 90) {
                      labelColor = Colors.blue;
                    } else if (details.value <= 99) {
                      labelColor = Colors.green;
                    } else {
                      labelColor = Colors.red;
                    }

                    return ChartAxisLabel(
                      details.text,
                      TextStyle(
                        color: labelColor, // Set the label color based on the temperature range
                        fontSize: 12.sp,
                      ),
                    );
                  },
                ),
                series: <CartesianSeries>[
                  // Weekly Temperature Data
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: weeklyTemperatureData,
                    xValueMapper: (_ChartData data, _) => data.time, // X-axis labels (week days)
                    yValueMapper: (_ChartData data, _) => data.temperature, // Y-axis values (temperature)
                    gradient: LinearGradient(
                      colors: AppColors.redColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.barGraphRed1,
                    borderWidth: 2,
                    name: 'Weekly Temperature',
                  ),
                ],
                tooltipBehavior: TooltipBehavior(enable: true), // Enable tooltips on hover
              ),
            ),
            SizedBox(height: 16.h,),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TrackerAverageWidget(title: 'Average',value: avgPulse),
                  TrackerAverageWidget(title: 'Maximum',value: maxPulse),
                  TrackerAverageWidget(title: 'Minimum',value: minPulse),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

// Class to hold chart data
class _ChartData {
  final String time; // This will be the day of the week
  final num temperature;

  _ChartData(this.time, this.temperature);
}
