import 'package:covid_tracker/services/state_servises.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    StateServices services = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {
                    
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  ),

                ),
              ),
            ),
            Expanded(

                child: FutureBuilder(
                  future: services.countrieslistApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>>snapshot){

                    if(!snapshot.hasData){

                      return   ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade600,
                                highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title:Container(height: 10,width: 89,color: Colors.white,) ,
                                    subtitle:Container(height: 10,width: 89,color: Colors.white,),
                                    leading:  Container(height: 50,width: 50,color: Colors.white,),
                                  )
                                ],
                              ),

                            );
                          });


                    }else
                      {
                       return ListView.builder(
                           itemCount: snapshot.data!.length,
                           itemBuilder: (context,index){

                             String name = snapshot.data![index]['country'];

                             if(_searchController.text.isEmpty)
                               {
                                 return Column(
                                   children: [

                                     ListTile(
                                       title:  Text(snapshot.data![index]['country']),
                                       subtitle:Text(snapshot.data![index]['cases'].toString()) ,
                                       leading: Image(
                                         height: 50,
                                         width: 50,
                                         image: NetworkImage(
                                             snapshot.data![index]['countryInfo']['flag']
                                         ),),
                                     )
                                   ],
                                 );

                               }else if(name.toLowerCase().contains(_searchController.text.toLowerCase()))
                                 {
                                    return Column(
                                     children: [

                                       ListTile(
                                         title:  Text(snapshot.data![index]['country']),
                                         subtitle:Text(snapshot.data![index]['cases'].toString()) ,
                                         leading: Image(
                                           height: 50,
                                           width: 50,
                                           image: NetworkImage(
                                               snapshot.data![index]['countryInfo']['flag']
                                           ),),
                                       )
                                     ],
                                   );

                                 }
                             else
                               {
                                 return Container();
                               }


                           });
                      }


                  },
                ))
          ],
        ),
      ),

    );
  }
}
