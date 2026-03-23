import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Completion Rate", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 85, color: Colors.green, title: '85%'),
                    PieChartSectionData(value: 15, color: Colors.red, title: '15%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text("Weekly Trend", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5, color: Colors.deepPurple)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 7, color: Colors.deepPurple)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 8, color: Colors.deepPurple)]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}