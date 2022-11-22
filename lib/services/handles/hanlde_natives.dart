import 'package:flutter/material.dart';

import '../api-service/saavnn_api.dart';

void handleSharedText(
  String sharedText,
  GlobalKey<NavigatorState> navigatorKey,
) {
  final route = HandleRoute.handleRoute(sharedText);
  if (route != null) navigatorKey.currentState?.push(route);
}

// ignore: avoid_classes_with_only_static_members
class HandleRoute {
  static Route? handleRoute(String? url) {
    if (url == null) return null;
    if (url.contains('saavn')) {
      final RegExpMatch? songResult =
          RegExp(r'.*saavn.com.*?\/(song)\/.*?\/(.*)').firstMatch('$url?');
      if (songResult != null) {
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => SaavnUrlHandler(
            token: songResult[2]!,
            type: songResult[1]!,
          ),
        );
      } else {
        final RegExpMatch? playlistResult = RegExp(
          r'.*saavn.com\/?s?\/(featured|playlist|album)\/.*\/(.*_)?[?/]',
        ).firstMatch('$url?');
        if (playlistResult != null) {
          return PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => SaavnUrlHandler(
              token: playlistResult[2]!,
              type: playlistResult[1]!,
            ),
          );
        }
      }
    } else if (url.contains('spotify')) {
      // TODO: Add support for spotify links
      // print('it is a spotify link');
    } else if (url.contains('youtube')) {
      // TODO: Add support for youtube links
      // print('it is an youtube link');
      final RegExpMatch? videoId =
          RegExp(r'.*\.com\/watch\?v=(.*)\?').firstMatch('$url?');
      if (videoId != null) {
        // TODO: Extract audio data and play audio
        // return PageRouteBuilder(
        //   opaque: false,
        //   pageBuilder: (_, __, ___) => YtUrlHandler(
        //     id: songResult[1]!,
        //     type: song,
        //   ),
        // );
      }
    } else {
      final RegExpMatch? fileResult =
          RegExp(r'\/[0-9]+\/([0-9]+)\/').firstMatch('$url/');
      if (fileResult != null) {
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => OfflinePlayHandler(
            id: fileResult[1]!,
          ),
        );
      }
    }
    return null;
  }
}

class SaavnUrlHandler extends StatelessWidget {
  final String token;
  final String type;

  const SaavnUrlHandler({super.key, required this.token, required this.type});

  @override
  Widget build(BuildContext context) {
    JioSaavnApi().getSongFromToken(token, type).then((value) {
      if (type == 'song') {
        // Navigator.pushReplacement(
        //   context,
        //   PageRouteBuilder(
        //     opaque: false,
        //     pageBuilder: (_, __, ___) => PlayScreen(
        //       songsList: value['songs'] as List,
        //       index: 0,
        //       offline: false,
        //       fromDownloads: false,
        //       recommend: true,
        //       fromMiniplayer: false,
        //     ),
        //   ),
        // );
      }
      if (type == 'album' || type == 'playlist' || type == 'featured') {
        // Navigator.pushReplacement(
        //   context,
        //   PageRouteBuilder(
        //     opaque: false,
        //     pageBuilder: (_, __, ___) => SongsListPage(
        //       listItem: value,
        //     ),
        //   ),
        // );
      }
    });
    return Container();
  }
}

class OfflinePlayHandler extends StatelessWidget {
  final String id;

  const OfflinePlayHandler({super.key, required this.id});

  // Future<List> playOfflineSong(String id) async {
  //   final OfflineAudioQuery offlineAudioQuery = OfflineAudioQuery();
  //   await offlineAudioQuery.requestPermission();
  //
  //   final List<SongModel> songs = await offlineAudioQuery.getSongs();
  //   final int index = songs.indexWhere((i) => i.id.toString() == id);
  //
  //   return [index, songs];
  // }

  @override
  Widget build(BuildContext context) {
    // playOfflineSong(id).then((value) {
    // Navigator.pushReplacement(
    //   context,
    //   PageRouteBuilder(
    //     opaque: false,
    //     pageBuilder: (_, __, ___) => PlayScreen(
    //       songsList: value[1] as List<SongModel>,
    //       index: value[0] as int,
    //       offline: true,
    //       fromDownloads: false,
    //       recommend: false,
    //       fromMiniplayer: false,
    //     ),
    //   ),
    // );
    // });
    return Container();
  }
}