import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LinearChart extends StatefulWidget {
  const LinearChart({super.key});

  @override
  State<StatefulWidget> createState() => LinearChartState();
}

class LinearChartState extends State<LinearChart> {
  final Color barBackgroundColor = const Color(0x6472d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AspectRatio(
        aspectRatio: 3,
        child: BarChart(
          mainBarData(),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.amberAccent,
    double width = 20,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 2 : y,
          color: isTouched ? Colors.amber : barColor,
          width: width,
          borderSide: isTouched ? BorderSide(color: Colors.amber) : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 18,
            color: barBackgroundColor,
          ),
        ),
      ],
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: [
        makeGroupData(0, 5, barColor: Colors.deepOrange),
      ],
      gridData: FlGridData(show: false),
    );
  }
}
