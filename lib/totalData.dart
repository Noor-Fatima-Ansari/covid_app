import 'package:covid_app/ApiModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'api.dart';
import 'countries_list.dart';



class RowCall extends StatelessWidget {
  final String name;
  final String value;
   RowCall({super.key, required this.name,required this.value });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(

        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(name , style: TextStyle(color: Colors.white, fontSize: 20),),
          SizedBox(width: 20,),
          Text(value ,style: TextStyle(color: Colors.white, fontSize: 20),),
        ],
      ),
    );
  }
}





class TotalData extends StatefulWidget {
  const TotalData({super.key});

  @override
  State<TotalData> createState() => _TotalDataState();
}

class _TotalDataState extends State<TotalData> with TickerProviderStateMixin{

  late final AnimationController controller= AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body : SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
                future: ApiDeclare().callRecord(),
                builder: (context, AsyncSnapshot<ApiModal> snapshot){
              if(snapshot.hasData){
                return Padding(
                  padding:  EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                        PieChart(
                        dataMap: {
                          'Critical': double.parse(snapshot.data!.critical!.toString()),
                          'Deaths': double.parse(snapshot.data!.deaths!.toString()),
                          'Recovered': double.parse(snapshot.data!.recovered!.toString()),
                          'Cases': double.parse(snapshot.data!.cases!.toString()),
                        },
                        chartRadius: 120,
                        chartType: ChartType.ring,
                        animationDuration: Duration(milliseconds: 1200),
                        colorList: [
                          Colors.blue, Colors.red, Colors.green, Colors.cyanAccent
                        ],
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left
                        ),

                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesOutside: true,
                          showChartValuesInPercentage: true,
                        ),
                      ),
                      SizedBox(height: 30,),

                      Card(
                          color: Colors.teal,
                          shadowColor: Colors.teal.withOpacity(0.8),
                          child:  Column(
                            children: [
                              RowCall(name: 'cases', value: snapshot.data!.cases!.toString()),
                              RowCall(name: 'Active', value: snapshot.data!.active!.toString()),
                              RowCall(name: 'Recovered', value: snapshot.data!.recovered!.toString() ),
                              RowCall(name: 'Deaths', value: snapshot.data!.deaths!.toString() ),

                            ],
                          )

                      ),
                      Divider(),
                      SizedBox(height: 20,),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child:     GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesList()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .09,
                            width: MediaQuery.of(context).size.height * .5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal,
                            ),
                            child: Center(child: Text('Track Countries',style:  TextStyle(color: Colors.white, fontSize: 20),)),
                          ),
                        ),

                      ),



                    ],
                  ),
                );

              }
              else{
                return Center(
                  child: SpinKitFadingCircle(
                    size: 50.0,
                    controller: controller,
                    color: Colors.white12,
                  ),
                );
              }

            }

            ),
          ],
        ),
        

      )
    );
  }
}
//
// color: Colors.teal.withOpacity(0.8),
//
// ),

