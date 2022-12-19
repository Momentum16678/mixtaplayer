// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixtaplayer/music_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  //To play the song
  playSong(String? uri){
    try {
      _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioPlayer.play();
    } on Exception {
      print("Error parsing songs");
    }

  }
  //WillPopScope
  //This is the method used to avoid taking user back to login when they press back button
  //
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await _showExitBottomSheet(context);
    return exitResult ?? false;
    // bool? exitResult = false;
    // return exitResult;
  }

  Future<bool?> _showExitBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: _buildBottomSheet(context),
        );
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          'Do you really want to exit the app?',
          style: TextStyle(
            color: Color(0xFF660099),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Color(0xFF660099), fontSize: 16),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'YES, EXIT',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  var newIndex;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 30, left: 8, right: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0E0116), Color(0xFF300347), Color(0xFF0E0116)],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Mixtaplayer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                // Image.asset(
                //"assets/images/logo.png",
                // width: 100,
                //height: 40,
                //),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _audioPlayer.play();
                        },
                        child: Expanded(
                          child: Container(
                               width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFF660099),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              height: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Play all",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              )),
                        ),
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () async {
                          await _audioPlayer.shuffle();
                        },
                        child: Expanded(
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              color: Color(0xFF660099),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shuffle_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Shuffle all",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Icon(
                //         Icons.headphones,
                //         color: Colors.white,
                //       ),
                //       SizedBox(width: 5),
                //       Text(
                //         "45 mins . 100 songs",
                //         style: TextStyle(color: Colors.white, fontSize: 16),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Container(
                    // margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width,
                    // decoration: BoxDecoration(color: Colors.white70),
                    height: MediaQuery.of(context).size.height * 0.76,
                    child: FutureBuilder<List<SongModel>>(
                      future: _audioQuery.querySongs(
                        sortType: null,
                        orderType: OrderType.ASC_OR_SMALLER,
                        ignoreCase: true,
                        uriType: UriType.EXTERNAL,
                      ),
                      builder: (context, item) {
                        if (item.data == null) {
                          return const CircularProgressIndicator();
                        }
                        if (item.data!.isEmpty) {
                          return const Center(child: Text("No songs found"));
                        }
                        return Column(
                          children: [
                            Container(
                               margin: EdgeInsets.only(top: 5),
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.headphones,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "45 mins . ${item.data!.length} songs",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: item.data!.length,
                                  itemBuilder: (context, index) {
                                    if ((item.data![index].fileExtension ==
                                            'mp3') &&
                                        (item.data![index].duration! > 600)) {
                                      newIndex = item.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            MusicPlayer(songModel: item.data![index], audioPlayer: _audioPlayer),
                                              ),
                                            );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          height: 90,
                                          margin: EdgeInsets.only(bottom: 5),
                                          padding: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Row(
                                              children: [
                                            QueryArtworkWidget(
                                              artworkBorder: BorderRadius.zero,
                                              artworkWidth: 100,
                                              artworkHeight: 75,
                                              id: item.data![index].id,
                                              nullArtworkWidget: Image.asset(
                                                "assets/images/fb_icon.jpg",
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                              type: ArtworkType.AUDIO,
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.data![index].title,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xFF660099),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    item.data![index].artist!,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xFF660099),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Icon(Icons.more_vert),
                                            SizedBox(
                                              width: 4,
                                            )
                                          ]),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
