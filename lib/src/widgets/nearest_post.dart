import 'package:flutter/material.dart';
import 'nearest_card.dart';

//Data
import '../data/target_data.dart';


  class NearestPost extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Container(
        height: 140.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: TargetData.targets.length,
          itemBuilder: (BuildContext context, int index){
            return NearestCard(
              imagePost: TargetData.targets[index].foto,
              // titlePost: _populars[index].titlePost,
            );
          },
        ),
      );
    }
  }
  