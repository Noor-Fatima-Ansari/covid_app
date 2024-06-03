import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'api.dart';
import 'country.dart';
class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController controller= TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: ApiCountries().countryRecord(),
            builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
              if(!snapshot.hasData){
                return  ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index){
                      return SafeArea(
                        child: Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(height: 50 , width: 50, color: Colors.white,),
                                    title: Container(
                                      width: 100,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    subtitle:Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                );
              }




              else{
                return SafeArea(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width* .9,
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                hintText: 'search for country',
                               suffixIcon: controller.text.isEmpty? Icon(Icons.search):
                               GestureDetector(
                                 child: Icon(Icons.clear),
                                 onTap: (){
                                   controller.text=' ';
                                   setState(() {
                                   });
                                 },
                               )
                            ),
                            onChanged: (value){
                              setState(() {

                              });
                            },

                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){
                                return snapshot.data![index]['country'].toString().toLowerCase().contains(controller.text.toString().toLowerCase()) ?
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Country(

                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'] ,
                                      totalCases:  snapshot.data![index]['cases'] ,
                                      totalRecovered: snapshot.data![index]['recovered'] ,
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'] ,


                                    )));
                                      },
                                      child: ListTile(
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                        title: Text(snapshot.data![index]['country']) ,
                                        subtitle:  Text( snapshot.data![index]['cases'].toString()) ,
                                      ),
                                    ),
                                    Divider()
                                  ],
                                )

                               :
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Country(

                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          name: snapshot.data![index]['country'] ,
                                          totalCases:  snapshot.data![index]['cases'] ,
                                          totalRecovered: snapshot.data![index]['recovered'] ,
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          active: snapshot.data![index]['active'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecovered: snapshot.data![index]['todayRecovered'],
                                          critical: snapshot.data![index]['critical'] ,

                                        )));
                                      },

                                      child: ListTile(
                                        leading: Container(
                                          height: 50 , width: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString()),
                                              )
                                          ),
                                        ),
                                        title: Text(snapshot.data![index]['country'].toString()),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                )   ;

                              }
                          ),
                        ),



                      ),


                    ],
                  ),
                );






              }


        }
        ),
      ),
    );


  }
}
























