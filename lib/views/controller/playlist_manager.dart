import 'package:cloud_music/services/api-service/spotify_api.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/spotify_playlist.dart';
import '../list_of_songs.dart';

List<UserPlayList>? playListOfUser = [];

class PlayList extends StatelessWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return FutureBuilder<List<UserPlayList>>(
        future: spotifyApi.getUserPlaylists(
            Hive.box('secrets').get('access-token', defaultValue: [""])[0]),
        builder: (context, AsyncSnapshot<List<UserPlayList>> snapshot) {
          if (snapshot.hasData) {
            playListOfUser = snapshot.data;
            return SizedBox(
              height: 90,
              child: ListView.builder(
                itemCount: playListOfUser?.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SongsList(
                            playlistName: '${playListOfUser?[index].name}',
                            playlistId: "${playListOfUser?[index].id}",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3.4)),
                        color: const Color(0xff2a2a2a),
                        image: DecorationImage(
                          image: NetworkImage(
                              "${playListOfUser?[index].imageUrl}"),
                          fit: BoxFit.cover,
                          opacity: 0.5,
                        ),
                      ),
                      margin: const EdgeInsets.all(3.5),
                      alignment: Alignment.center,
                      child: Text(
                        "  ${playListOfUser?[index].name} |",
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black54,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const Text("Loading...");
          }
        });
  }
}
