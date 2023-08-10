import 'package:covid_tracker/modal/WorldStateModal.dart';
import 'package:covid_tracker/screen/counteris/countries.dart';
import 'package:covid_tracker/services/state_servises.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration:const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff81e7b6),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {

    StateServices services = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01,),

              FutureBuilder(
                  future: services.fatchWorldStateModalRecords(),
                  builder: (context,AsyncSnapshot<WorldStateModal>snapshot){

                    if(!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.yellow,
                            size: 50.0,
                            controller: _controller,
                          ));

                    }else
                    {
                      return  Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: PieChart(
                              dataMap:{

                                "Total":double.parse(snapshot.data!.cases!.toString()),
                                "Recovered":double.parse(snapshot.data!.recovered.toString()),
                                "Deaths":double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                              colorList: colorlist,),
                          ),
                          Card(
                            child: Column(
                              children: [

                                ResuableRow(title: 'Total',value: snapshot.data!.cases.toString(),),
                                ResuableRow(title: 'Deaths',value: snapshot.data!.deaths.toString(),),
                                ResuableRow(title: 'Recovered',value: snapshot.data!.recovered.toString(),),
                                ResuableRow(title: 'Active',value: snapshot.data!.active.toString(),),
                                ResuableRow(title: 'Critical',value: snapshot.data!.critical.toString(),),
                                ResuableRow(title: 'TodayDeaths',value: snapshot.data!.todayDeaths.toString(),),
                                ResuableRow(title: 'TodayRecovered',value: snapshot.data!.todayRecovered.toString(),),



                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: (){
                              print("object");
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Countries()));


                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff80ecb8)
                              ),
                              child: Center(
                                child: Text("Track Countires"),
                              ),
                            ),
                          )

                        ],
                      );

                    }
                  }),


            ],
          ),
        ),
      ),
    );
  }
}
class ResuableRow extends StatelessWidget {

  String title,value;
   ResuableRow({super.key,required this.title,required this.value});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}

