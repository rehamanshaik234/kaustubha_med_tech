import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaustubha_medtech/views/widgets/tracker_widgets/tracker_graph/tracker_average_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kaustubha_medtech/controller/providers/tracker/tracker.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class TrackerStressDailyGraph extends StatefulWidget {
  const TrackerStressDailyGraph({super.key});

  @override
  State<TrackerStressDailyGraph> createState() => _TrackerStressDailyGraphState();
}

class _TrackerStressDailyGraphState extends State<TrackerStressDailyGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrackerProvider>(
      builder: (context, provider, child) {
        List<_ChartData> dailyData = provider.tracker.healthMonitoring?.dailyMonitoring
            ?.map((data) => _ChartData(data.day ?? '', data.stressLevel ?? 1))
            .toList() ??
            [];

        final pulseValues = dailyData.map((data) => data.stress).toList();
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
                  interval: 80, // Set the Y-axis interval to 50
                  majorGridLines: const MajorGridLines(width: 1), // Enable horizontal grid lines
                  minimum: 0,  // Start the Y-axis from 0
                  maximum: 400, // Adjust the maximum based on pulse range
                  axisLabelFormatter: (AxisLabelRenderDetails details) {
                    Color labelColor;
                    // Custom logic to change label color based on value
                    if (details.value <= 150) {
                      labelColor = Colors.green;
                    } else if (details.value <= 200) {
                      labelColor = Colors.yellow;
                    } else if (details.value <= 300) {
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
                  // Daily Pulse Data
                  SplineAreaSeries<_ChartData, String>(
                    dataSource: dailyData,
                    xValueMapper: (_ChartData data, _) => data.time, // X-axis labels (days)
                    yValueMapper: (_ChartData data, _) => data.stress, // Y-axis values (pulse)
                    gradient: LinearGradient(
                      colors: AppColors.redColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.barGraphRed1,
                    borderWidth: 2,
                    name: 'Daily Stress',
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
  final String time;
  final num stress;

  _ChartData(this.time, this.stress);
}
