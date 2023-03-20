import 'package:counter_client/colors.dart';
import 'package:counter_client/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  int selectedTime = 0;

  var chartData = [
    day1,
    wek1,
    mon1,
    year1,
    year5,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
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
                          stockColors[widget.index].withOpacity(0.5),
                          stockColors[widget.index].withOpacity(0.0),
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
                    color: stockColors[widget.index],
                    spots: chartData[selectedTime],
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
          // make this container fixed at bottom
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: stockColors[widget.index],
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              // create section for buttons
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // create button for 1D
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = 0;
                      });
                    },
                    child: Text(
                      '1D',
                      style: TextStyle(
                        color: selectedTime == 0
                            ? stockColors[widget.index]
                            : Colors.white,
                      ),
                    ),
                  ),
                  // create button for 1W
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = 1;
                      });
                    },
                    child: Text(
                      '1W',
                      style: TextStyle(
                        color: selectedTime == 1
                            ? stockColors[widget.index]
                            : Colors.white,
                      ),
                    ),
                  ),
                  // create button for 1M
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = 2;
                      });
                    },
                    child: Text(
                      '1M',
                      style: TextStyle(
                        color: selectedTime == 2
                            ? stockColors[widget.index]
                            : Colors.white,
                      ),
                    ),
                  ),
                  // create button for 1Y
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = 3;
                      });
                    },
                    child: Text(
                      '1Y',
                      style: TextStyle(
                        color: selectedTime == 3
                            ? stockColors[widget.index]
                            : Colors.white,
                      ),
                    ),
                  ),
                  // create button for ALL
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = 4;
                      });
                    },
                    child: Text(
                      'ALL',
                      style: TextStyle(
                        color: selectedTime == 4
                            ? stockColors[widget.index]
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
