import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';



class Echarts extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Echarts({Key? key}) : super(key: key);

  @override
  _EchartsPageState createState() => _EchartsPageState();
}

class _EchartsPageState extends State<Echarts> {
  List<_SalesData> data = [
    _SalesData('0725', 35),
    _SalesData('0726', 28),
    _SalesData('0727', 34),
    _SalesData('0728', 32),
    _SalesData('0729', 40),
    _SalesData('0730', 10),
    _SalesData('0731', 11),
  ];

  List<_SalesData> data2 = [
    _SalesData('0725', 45),
    _SalesData('0726', 38),
    _SalesData('0727', 44),
    _SalesData('0728', 32),
    _SalesData('0729', 45),
    _SalesData('0730', 17),
    _SalesData('0731', 19),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              // Chart title
              title: ChartTitle(text: '近七天经营业绩'),
              // Enable legend
              legend: Legend(
                  isVisible: true,
              ),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              plotAreaBorderWidth: 0,

              primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 10,
                majorGridLines: MajorGridLines(width: 1),
                title: AxisTitle(text: 'y轴')
              ),

              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                title: AxisTitle(text: 'x轴'),
                  associatedAxisName: 'as'
              ),

              // primaryXAxis: CategoryAxis(),

              // primaryXAxis: NumericAxis(),

              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: '销售金额',
                    markerSettings: MarkerSettings(
                      shape: DataMarkerType.rectangle
                    ),
                    // Enable data label
                    enableTooltip: true,
                    dataLabelSettings: DataLabelSettings(isVisible: false,)
                ),
                LineSeries<_SalesData, String>(
                    dataSource: data2,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: '销售当日欠款',
                    enableTooltip: true,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                    ))
              ]),
        ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}