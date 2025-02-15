import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MarketVolatilityScreen extends StatelessWidget {
  const MarketVolatilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'වෙළදපල විචලනය',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: PriceLineChart(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceLineChart extends StatelessWidget {
  final List<double> prices = [10, 50, 20, 30, 25, 40, 90];
  final List<String> days = ["Mon", "Tues", "Wed", "Thur", "Fri", "Sat", "Sun"];

  PriceLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(days[value.toInt()]);
              },
              interval: 1,
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              prices.length,
              (index) => FlSpot(index.toDouble(), prices[index]),
            ),
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: true),
            barWidth: 2,
          ),
        ],
      ),
    );
  }
}
