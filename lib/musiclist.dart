// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
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
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  var newIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0E0116), Color(0xFF300347), Color(0xFF0E0116)],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logo.png",
              // width: 100,
              height: 40,
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        )),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
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
                            "Download all",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
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
                    "45 mins . 100 songs",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(color: Colors.white70),
              height: MediaQuery.of(context).size.height * 0.63,
              child: Container(
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
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          if ((item.data![index].fileExtension == 'mp3') &&
                              (item.data![index].duration! > 600)) {
                            newIndex = item.data![index];
                            return GestureDetector(
                              onTap: () {
                                print(item.data![index].albumId);
                              },
                              // child: ListTile(
                              //   tileColor: Colors.white,
                              //   title: Text(item.data![index].title),
                              //   subtitle: Text(item.data![index].artist!),
                              //   trailing: const Icon(Icons.more_vert),
                              //   leading: QueryArtworkWidget(
                              //     id: item.data![index].id,
                              //     nullArtworkWidget: Image.asset(
                              //       "assets/images/2pac.jpg",
                              //       fit: BoxFit.cover,
                              //       width: 50,
                              //       height: 50,
                              //     ),
                              //     type: ArtworkType.AUDIO,
                              //   ),
                              // ),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                height: 65,
                                margin: EdgeInsets.only(bottom: 2),
                                padding: EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Row(children: [
                                  QueryArtworkWidget(
                                    artworkBorder: BorderRadius.zero,
                                    artworkWidth: 100,
                                    artworkHeight: 50,
                                    id: item.data![index].id,
                                    nullArtworkWidget: Image.asset(
                                      "assets/images/2pac.jpg",
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
                                              color: Color(0xFF660099),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          item.data![index].artist!,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF660099),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.more_vert),
                                  SizedBox(
                                    width: 8,
                                  )
                                ]),
                              ),
                            );
                          }
                          return Container();
                        });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
