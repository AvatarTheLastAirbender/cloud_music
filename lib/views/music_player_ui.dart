import 'package:cloud_music/views/custom/bottom_player.dart';
import 'package:flutter/material.dart';
import 'custom/player_body.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2a2a2a),
      body: const PlayerBody(),
      bottomNavigationBar: BottomPlayer(isPlayeListScreen: false),
    );
  }
}
