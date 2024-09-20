import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../tracker_average_widget.dart';

class TrackerHeartBeatMonthlyGraph extends StatefulWidget {
  const TrackerHeartBeatMonthlyGraph({super.key});

  @override
  State<TrackerHeartBeatMonthlyGraph> createState() => _TrackerHeartBeatMonthlyGraphState();
}

class _TrackerHeartBeatMonthlyGraphState extends State<TrackerHeartBeatMonthlyGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerProvider>(
      builder: (context, provider, child) {
        // Extract the monthly pulse data from the provider
        List<_ChartData> monthlyData = provider.tracker.healthMonitoring?.monthlyMonitoring
            ?.map((data) => _ChartData(data.month ?? "", data.pulse ?? 1))
            .toList() ??
            [];

        final pulseValues = monthlyData.map((data) => data.pulse).toList();
        final minPulse = pulseValues.isNotEmpty ? pulseValues.reduce((a, b) => a < b ? a : b) : 0;
        final maxPulse = pulseValues.isNotEmpty ? pulseValues.reduce((a, b) => a > b ? a : b) : 0;
        final avgPulse = pulseValues.isNotEmpty ? pulseValues.reduce((a, b) => a + b) / pulseValues.length : 0;

        return Column(
          children: [
            SizedBox(
              height: 250.h,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(fontSize: 8.sp),
                  majorGridLines: const MajorGridLines(width: 0), // Disable vertical grid lines
                ),
                primaryYAxis: NumericAxis(
                  interval: 50, // Set the Y-axis interval to 50
                  majorGridLines: const MajorGridLines(width: 1), // Enable horizontal grid lines
                  minimum: 0,  // Start the Y-axis from 0
                  maximum: 250, // Adjust the maximum based on pulse range
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    Color labelColor;

                    // Custom logic to change label color based on value
                    if (details.value <= 100) {
                      labelColor = Colors.green;
                    } else if (details.value <= 150) {
                      labelColor = Colors.yellow;
                    } else if (details.value <= 200) {
                      labelColor = Colors.orange;
                    } else {
                      labelColor = Colors.red;
                    }

                    return ChartAxisLabel(
                      details.text,
                      TextStyle(
                        color: labelColor, // Set the label color based on the value range
                        fontSize: 12.sp,
                      ),
                    );
                  },
                ),
                series: <CartesianSeries>[
                  // Monthly Pulse Data
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: monthlyData,
                    xValueMapper: (_ChartData data, _) => data.time, // X-axis labels (months)
                    yValueMapper: (_ChartData data, _) => data.pulse, // Y-axis values (pulse)
                    gradient: LinearGradient(
                      colors: AppColors.blueColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.barGraphBlue1,
                    borderWidth: 2,
                    name: 'Monthly Pulse',
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
  final String time; // This will be the month name or number
  final num pulse;

  _ChartData(this.time, this.pulse);
}
