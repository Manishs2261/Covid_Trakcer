import 'package:covid_tracker/screen/home/world_states.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totolCase,totolDeaths,totalRecovered,active,critical,todayRecovery,test;


  DetailsScreen({
     required this.name,
    required this.image,
    required this.totolCase,
    required this.totolDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovery,
    required this.test});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      ResuableRow(title: 'Cases', value: widget.totolCase.toString()),
                      ResuableRow(title: 'Cases', value: widget.totolCase.toString()),
                      ResuableRow(title: 'Cases', value: widget.totolCase.toString()),
                      ResuableRow(title: 'Cases', value: widget.totolCase.toString()),
                      ResuableRow(title: 'Cases', value: widget.totolCase.toString()),
                      ResuableRow(title: 'Cases', value: widget.totolCase.toString()),
                      ResuableRow(title: 'Cases', value: widget.totolCase.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(radius: 50,
              backgroundImage: NetworkImage(widget.image),)

            ],
          )
        ],
      ),

    );
  }
}
