import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:orda/core/extensions/build_context_extension.dart';

class WeeklyBarChart extends StatefulWidget {
  const WeeklyBarChart({
    required this.data,
    required this.maxY,
    super.key,
  });

  final List<num> data;
  final double maxY;

  @override
  State<WeeklyBarChart> createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  Widget getTitles(double value, TitleMeta meta) {
    final style = context.textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.bold,
    );
    final text = switch (value.toInt()) {
      0 => 'Mon',
      1 => 'Tue',
      2 => 'Wed',
      3 => 'Thu',
      4 => 'Fri',
      5 => 'Sat',
      6 => 'Sun',
      _ => '',
    };
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: context.textTheme.bodyMedium!.fontSize! * 2,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(),
    topTitles: const AxisTitles(),
    rightTitles: const AxisTitles(),
  );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      context.colors.primary,
      context.colors.primary.withValues(alpha: .2),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups =>
      widget.data.asMap().entries.map((entry) {
        final i = entry.key;
        final value = entry.value.round();
        return BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value.toDouble(),
              gradient: _barsGradient,
              label: BarChartRodLabel(text: '${value}k'),
            ),
          ],
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutQuad,
        BarChartData(
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: widget.maxY,
        ),
      ),
    );
  }
}
