import 'package:flutter/material.dart';
import 'popular_card.dart';

//Data
import '../data/popular_data.dart';

//Model
import '../models/popular_model.dart';

  class PopularPost extends StatelessWidget {

    final List<Popular> _populars = populars;

    @override
    Widget build(BuildContext context) {
      return Container(
        height: 174.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _populars.length,
          itemBuilder: (BuildContext context, int index){
            return PopularCard(
              imagePost: _populars[index].imagePost,
              titlePost: _populars[index].titlePost,
            );
          },
        ),
      );
    }
  }
  