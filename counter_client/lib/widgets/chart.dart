import 'package:counter_client/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            gridData: FlGridData(
              show: false,
            ),
            backgroundColor: Colors.transparent,
            lineBarsData: [
              LineChartBarData(
                showingIndicators: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      stockColors[index].withOpacity(0.5),
                      stockColors[index].withOpacity(0.0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                shadow: const Shadow(
                  color: Color(0xFF00EB7A),
                  offset: Offset(0, 2),
                  blurRadius: 10,
                ),
                color: stockColors[index],
                spots: [
                  const FlSpot(0, 10),
                  const FlSpot(5, 15),
                  const FlSpot(10, 10),
                  const FlSpot(15, 8),
                  const FlSpot(20, 12),
                  const FlSpot(25, 5),
                  const FlSpot(30, 16),
                  const FlSpot(35, 20),
                  const FlSpot(40, 18),
                  const FlSpot(45, 22),
                ],
                isCurved: true,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                ),
              ),
            ],
            minY: 0,
          ),
          swapAnimationDuration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }
}
