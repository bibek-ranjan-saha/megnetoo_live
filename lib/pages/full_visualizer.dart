import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:megnetoo_live/models/live_data.dart';
import 'package:megnetoo_live/providers/magnitude_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FullVisualizer extends StatelessWidget {
  const FullVisualizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("EMF Detector"),
            ),
            body: Hero(
              tag: "full",
              child: Consumer<MagnitudeProvider>(
                builder: (context, model, child) => Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.all(12.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SfCartesianChart(
                      isTransposed: true,
                      title: ChartTitle(text: "x,y,z with Time"),
                      legend: Legend(
                        isVisible: true,
                        title: LegendTitle(text: "emf reading of your device"),
                      ),
                      series: <LineSeries<LiveData, double>>[
                        LineSeries<LiveData, double>(
                            dataSource: model.values,
                            color: Colors.red,
                            legendItemText: "X",
                            onRendererCreated:
                                (ChartSeriesController controller) {},
                            xValueMapper: (LiveData value, _) => model.x,
                            yValueMapper: (LiveData value, _) => value.time),
                        LineSeries<LiveData, double>(
                            dataSource: model.values,
                            color: Colors.blue,
                            legendItemText: "Y",
                            onRendererCreated:
                                (ChartSeriesController controller) {},
                            xValueMapper: (LiveData value, _) => model.y,
                            yValueMapper: (LiveData value, _) => value.time),
                        LineSeries<LiveData, double>(
                            dataSource: model.values,
                            color: Colors.green,
                            legendItemText: "Z",
                            onRendererCreated:
                                (ChartSeriesController controller) {},
                            xValueMapper: (LiveData value, _) => model.z,
                            yValueMapper: (LiveData value, _) => value.time),
                      ],
                      primaryXAxis: NumericAxis(
                        isVisible: false,
                        majorGridLines: const MajorGridLines(width: 0),
                        interval: 3,
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        title: AxisTitle(text: "Time (s)"),
                      ),
                      primaryYAxis: NumericAxis(
                        axisLine: const AxisLine(width: 0),
                        majorTickLines: const MajorTickLines(size: 0),
                        title: AxisTitle(text: "uTesla"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
