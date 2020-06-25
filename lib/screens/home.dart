import 'package:covid/bloc/b_global.dart';
import 'package:covid/bloc/b_indonesia.dart';
import 'package:covid/bloc/b_indonesia_daily.dart';
import 'package:covid/bloc/b_page_slide.dart';
import 'package:covid/model/m_daily_indonesia.dart';
import 'package:covid/model/m_global.dart';
import 'package:covid/model/m_indonesia.dart';
import 'package:covid/screens/global.dart';
import 'package:covid/utils/appStyle.dart';
import 'package:covid/utils/dateIndonesia.dart';
import 'package:covid/utils/number.dart';
import 'package:covid/widgets/buildCard.dart';
import 'package:covid/widgets/checkConnection.dart';
import 'package:covid/widgets/errorPage.dart';
import 'package:covid/widgets/pageSlider.dart';
import 'package:covid/widgets/shimmerCard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<PageSliderState> _sliderKey = GlobalKey();
  final IndonesiaBloc _indonesiaBloc = IndonesiaBloc();
  final DailyIndonesiaBloc _dailyIndonesiaBloc = DailyIndonesiaBloc();
  final GlobalBloc _globalBloc = GlobalBloc();
  final PageSlideBloc _pageSlideBloc = PageSlideBloc();

  @override
  void initState() {
    _indonesiaBloc.add(IndonesiaEvent());
    _dailyIndonesiaBloc.add(DailyIndonesiaEvent());
    _globalBloc.add(GlobalEvent());
    super.initState();
  }

  Future<void> _refreshContent() async {
    _indonesiaBloc.add(IndonesiaEvent());
    _dailyIndonesiaBloc.add(DailyIndonesiaEvent());
    _globalBloc.add(GlobalEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primary,
      appBar: buildAppBar(context),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;

          return CheckConnection(connected, child);
        },
        child: RefreshIndicator(
          onRefresh: _refreshContent,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<IndonesiaBloc>(create: (context) => _indonesiaBloc),
              BlocProvider<DailyIndonesiaBloc>(create: (context) => _dailyIndonesiaBloc),
              BlocProvider<GlobalBloc>(create: (context) => _globalBloc),
              BlocProvider<PageSlideBloc>(create: (context) => _pageSlideBloc),
            ],
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 14.0),
                      buildTitle(),

                      SizedBox(height: 18.0),
                      buildHeader(),

                      SizedBox(height: 18.0),
                      PageSlider(
                        key: _sliderKey,
                        pages: [
                          buildStatisticCard(),
                          BlocBuilder<GlobalBloc, GlobalState>(
                            builder: (BuildContext context, GlobalState state) {
                              if(state is GlobalLoading) {
                                return ShimmerCard();
                              }else if(state is GlobalFailure) {
                                return ErrorPage();
                              }else if(state is GlobalLoaded) {
                                GlobalModel data = state.globalModel;
                                String dateIndo = dateIndonesia(data.lastUpdate);

                                return Global(data: data, dateIndo: dateIndo);
                              }else{
                                return Container();
                              }
                            }
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.0),
                buildGraphic()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => ZoomDrawer.of(context).open(),
        child: Icon(EvaIcons.menu
      )),
      elevation: 0.0,
      backgroundColor: AppStyle.primary
    );
  }

  Row buildTitle() {
    return Row(
      children: <Widget>[
        Text("Statistics", style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontFamily: "ibm-medium"
        ))
      ]
    );
  }

  Widget buildGraphic() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Stack(
        children: <Widget>[
          Container(
            height: 380.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0),
              )
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 30.0, 28.0, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Kasus Perminggu", style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "ibm-medium"
                    ))
                  ]
                ),

                BlocBuilder<DailyIndonesiaBloc, DailyIndonesiaState>(
                  builder: (context, state) {
                    if(state is DailyIndonesiaLoading) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 40.0),
                          Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }else if(state is DailyIndonesiaFailure) {
                      return ErrorPage();
                    }else if(state is DailyIndonesiaLoaded) {
                      List<DailyIndonesiaModel> data = state.dailyindonesiaModel;
                      DateTime last = data[data.length - 1].date;

                      return Column(
                        children: <Widget>[
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              Text("Update terakhir: ${dateIndonesia(last)}", style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "ibm-light"
                              ))
                            ],
                          ),

                          SizedBox(height: 35.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: LineChart(
                                    sampleData1(data),
                                    swapAnimationDuration: const Duration(milliseconds: 250),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }else{
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LineChartData sampleData1(List<DailyIndonesiaModel> data) {
    List<String> date = [];
    for(int i = 0; i < data.length; i++) {
      DateTime now = data[i].date;
      date.add(now.day.toString());
    }

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(tooltipBgColor: Colors.blueGrey.withOpacity(0.8)),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            return date[value.toInt()];
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch(value.toInt()) {
              case 10000:
                return '10.000';
              case 20000:
                return '20.000';
              case 30000:
                return '30.000';
              case 40000:
                return '40.000';
              case 50000:
                return '50.000';
              case 60000:
                return '60.000';
            }

            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 3),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      minX: 0,
      maxX: 6,
      maxY: 60000,
      minY: 20000,
      lineBarsData: linesBarData1(data),
    );
  }

  List<LineChartBarData> linesBarData1(List<DailyIndonesiaModel> data) {
    List<FlSpot> _spots = [];

    for(int i = 0; i < data.length; i++) {
      _spots.add(FlSpot(i.toDouble(), data[i].confirmed.toDouble()));
    }

    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: _spots,
      isCurved: true,
      colors: [AppStyle.secondary],
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false)
    );

    return [
      lineChartBarData1
    ];
  }

  Container buildHeader() {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: AppStyle.secondary,
        borderRadius: BorderRadius.circular(50)
      ),
      padding: EdgeInsets.all(8.0),
      child: BlocListener<PageSlideBloc, PageSlideState>(
        listener: (context, state) {
          if (state is PageSlideFailed) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${state.error}'),
            ));
          }
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () { 
                  _pageSlideBloc.add(PageSlideEvent(Condition.active));
                  return _sliderKey.currentState.previous() ;
                },
                child: BlocBuilder<PageSlideBloc, PageSlideState>(
                  builder: (context, state) {
                    if (state is PageSlideInitial) {
                      return buildSlider("Indonesia", Colors.white, Colors.black);
                    } else if (state is PageSlideSuccess) {
                      return Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: (state.type) ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Indonesia", style: TextStyle(
                              color: (state.type) ? Colors.black : Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "ibm-regular"
                            )),
                          ],
                        ),
                      );
                    } else if (state is PageSlideFailed) {
                      return Text('Error: ${state.error}');
                    } else {
                      return Container();
                    }
                  }
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () {
                  _pageSlideBloc.add(PageSlideEvent(Condition.inactive));
                  return _sliderKey.currentState.setPage(1);
                },
                child: BlocBuilder<PageSlideBloc, PageSlideState>(
                  builder: (context, state) {
                    if (state is PageSlideInitial) {
                      return buildSlider("Global", Colors.transparent, Colors.white);
                    } else if (state is PageSlideSuccess) {
                      return Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: (!state.type) ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Global", style: TextStyle(
                              color: (!state.type) ? Colors.black : Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "ibm-regular"
                            )),
                          ],
                        ),
                      );
                    } else if (state is PageSlideFailed) {
                      return Text('Error: ${state.error}');
                    } else {
                      return Container();
                    }
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildSlider(String title, Color bg, Color color) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(
            color: color,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            fontFamily: "ibm-regular"
          )),
        ],
      ),
    );
  }

  BlocBuilder<IndonesiaBloc, IndonesiaState> buildStatisticCard() {
    return BlocBuilder<IndonesiaBloc, IndonesiaState>(
      builder: (context, state) {
        if(state is IndonesiaLoading) {
          return ShimmerCard();
        }else if(state is IndonesiaFailure) {
          return ErrorPage();
        }else if(state is IndonesiaLoaded) {
          IndonesiaModel data = state.indonesiaModel;
          String dateIndo = dateIndonesia(data.lastUpdate);

          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Update terakhir: $dateIndo", style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0
                  )),

                  GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "provinsi"),
                      child: Text("Lihat detail >", style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0
                    )),
                  ),
                ],
              ),

              SizedBox(height: 14.0),
              Row(
                children: <Widget>[
                  BuildCard(
                    title: "Total Positif",
                    total: number(data.confirmed.value),
                    color: AppStyle.warning,
                    img: "assets/images/sad.png"
                  )
                ],
              ),

              SizedBox(height: 14.0),
              Row(
                children: <Widget>[
                  BuildCard(
                    title: "Total Sembuh",
                    total: number(data.recovered.value),
                    color: AppStyle.success,
                    img: "assets/images/happy.png"
                  ),

                  SizedBox(width: 10.0),
                  BuildCard(
                    title: "Total Meninggal",
                    total: number(data.deaths.value),
                    color: AppStyle.danger,
                    img: "assets/images/crying.png"
                  ),
                ],
              ),
            ],
          );
        }else{
          return Container();
        }
      },
    );
  }
}