import 'package:flutter/material.dart';
import 'package:kaustubha_medtech/main.dart';
import 'package:kaustubha_medtech/utils/app_colors/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class SplineAreaChart extends StatelessWidget {
  final List<_ChartData> data = [
    _ChartData('January', 80, 98.6),
    _ChartData('February', 200, 80.1),
    _ChartData('March', 120, 97.9),
    _ChartData('April', 100, 95.3),
    _ChartData('May', 90, 98.7),
    _ChartData('June', 110, 99.0),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(fontSize: 0),
          majorGridLines: MajorGridLines(width: 0), // Enable vertical lines
        ),
        primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 1), // Disable horizontal lines
        ),
        series: <CartesianSeries>[
          SplineAreaSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (_ChartData data, _) => data.month,
            yValueMapper: (_ChartData data, _) => data.pulse,
            gradient:  LinearGradient(
              colors: AppColors.blueColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderColor: AppColors.barGraphBlue1,
            borderWidth: 2,
            name: 'Pulse',
          ),
          SplineAreaSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (_ChartData data, _) => data.month,
            yValueMapper: (_ChartData data, _) => data.temperature,
            gradient:  LinearGradient(
              colors: AppColors.redColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderColor: AppColors.barGraphRed1,
            borderWidth: 2,
            name: 'Temperature',
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.month, this.pulse, this.temperature);

  final String month;
  final double pulse;
  final double temperature;
}
