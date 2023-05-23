import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            width: 350.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(35.0),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.videogame_asset, color: Colors.white),
                Image.network(
                  'https://i.ibb.co/7gxCH8K/image.png',
                  height: 50,
                ),
                Image.network(
                  'https://i.ibb.co/FWRvVcs/image.png',
                  height: 40,
                ),
                Icon(Icons.settings, color: Colors.white),
                Icon(Icons.person_2_outlined, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
