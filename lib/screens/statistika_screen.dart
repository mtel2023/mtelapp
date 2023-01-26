import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:mtelapp/components/customAppbar.dart';
import 'package:mtelapp/providers/orders_provider.dart';
import 'package:mtelapp/screens/korpa_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StatistikaScreen extends StatefulWidget {
  static const String = '/statistika';
  const StatistikaScreen({super.key});

  @override
  State<StatistikaScreen> createState() => _StatistikaScreenState();
}

class _StatistikaScreenState extends State<StatistikaScreen> {
  bool isLoading = false;
  bool isInit = true;
  late TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).readOrders().then((value) {});
      await Provider.of<Orders>(context, listen: false).readOrdersByDate(date1, date2).then((value) {
        _tooltipBehavior = TooltipBehavior(
          enable: true,
          header: '',
        );
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        dismissDirection: DismissDirection.none,
        backgroundColor: Colors.white,
        content: Text(
          'Unesite datume pažljivo - prvi datum ne smije biti poslije drugog, a drugi datum ne smije biti prije prvog!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }

  DateTime date1 = DateTime.now().subtract(Duration(days: 7));
  DateTime date2 = DateTime.now();
  void datePicker1() {
    showDatePicker(
      context: context,
      initialDate: date1,
      firstDate: DateTime(2023),
      lastDate: date2,
    ).then((value) async {
      if (value == null) {
        return;
      }
      if (value.isAfter(date2)) {
        return;
      }

      setState(() {
        date1 = value;
      });
      await Provider.of<Orders>(context, listen: false).readOrdersByDate(date1, date2).then((value) {
        setState(() {});
      });
    });
  }

  void datePicker2() {
    showDatePicker(
      context: context,
      initialDate: date2,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((value) async {
      if (value == null) {
        return;
      } else if (value.isBefore(date1)) {
        showSnackBar();
      } else {
        setState(() {
          date2 = value.add(Duration(hours: 23));
        });
        await Provider.of<Orders>(context, listen: false).readOrdersByDate(date1, date2).then((value) {
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final medijakveri = MediaQuery.of(context);
    final orders = Provider.of<Orders>(context);

    final List<ChartSampleData> chartData = orders.getStatistikaOders;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Color.fromRGBO(243, 243, 243, 1),
            height: (medijakveri.size.height - medijakveri.padding.top),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                    child: CustomAppBar(
                      funkcija: () {},
                      prvaIkonica: Iconsax.home,
                      drugaIkonica: Iconsax.shopping_cart,
                      pageTitle: 'Statistika',
                      isBlack: false,
                      isChevron: true,
                      isCenter: false,
                      funkcija2: () {
                        Navigator.of(context).pushNamed(KorpaScreen.routeName);
                      },
                    ),
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.018),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08),
                    padding: EdgeInsets.symmetric(
                      horizontal: medijakveri.size.width * 0.03,
                      vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.03,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => datePicker1(),
                          child: Text(
                            '${DateFormat('dd. MMM y.').format(date1)}',
                            style: TextStyle(
                              color: Colors.transparent,
                              decorationColor: Colors.grey,
                              shadows: [Shadow(color: Colors.black, offset: Offset(0, -4))],
                              decoration: TextDecoration.underline,
                              decorationThickness: 3,
                            ),
                          ),
                        ),
                        Container(
                          width: 35,
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                        InkWell(
                          onTap: () => datePicker2(),
                          child: Text(
                            '${DateFormat('dd. MMM y.').format(date2)}',
                            style: TextStyle(
                              color: Colors.transparent,
                              decorationColor: Colors.grey,
                              shadows: [Shadow(color: Colors.black, offset: Offset(0, -4))],
                              decoration: TextDecoration.underline,
                              decorationThickness: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.0235),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.08),
                    child: Column(
                      children: [
                        SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.005),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: (medijakveri.size.height - medijakveri.padding.top) * 0.03,
                            horizontal: medijakveri.size.width * 0.02,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: medijakveri.size.width * 0.04),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${orders.getStatistikaTotal.toStringAsFixed(2)} €',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: (medijakveri.size.height - medijakveri.padding.top) * 0.03),
                              SfCartesianChart(
                                tooltipBehavior: _tooltipBehavior,
                                primaryXAxis: CategoryAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                  majorTickLines: MajorTickLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  majorTickLines: MajorTickLines(width: 0),
                                  axisLine: AxisLine(
                                    color: Colors.red,
                                    width: 0,
                                  ),
                                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  numberFormat: NumberFormat.currency(
                                    locale: 'fr_FR',
                                    symbol: '€',
                                  ),
                                  interval: 5,
                                ),
                                series: [
                                  StackedColumnSeries(
                                    color: Color.fromRGBO(108, 99, 255, 1),
                                    dataSource: chartData,
                                    xValueMapper: (ChartSampleData ch, _) => ch.x,
                                    yValueMapper: (ChartSampleData ch, _) => ch.y,
                                    // dataLabelSettings: DataLabelSettings(isVisible: true),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
