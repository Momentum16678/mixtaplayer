import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  //  var files;

  // void getFiles() async {
  //   //asyn function to get list of files
  //   List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
  //   var root = storageInfo[0]
  //       .rootDir; //storageInfo[1] for SD card, geting the root directory
  //   var fm = FileManager(root: Directory(root)); //
  //   files = await fm.filesTree(
  //       excludedPaths: ["/storage/emulated/0/Android"],
  //       extensions: ["mp3"] //optional, to filter files, list only mp3 files
  //       );
  //   setState(() {}); //update the UI
  // }
  var files;
  void getMusicFiles() async {
    //async to get List of files
    // List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    // var root = storageInfo[0].rootDir;
    // var fm = FileManager(root: Directory(path));
    // print(storageInfo);
    // print(root);
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
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  var newIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<SongModel>>(
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
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  if ((item.data![index].fileExtension == 'mp3') &&
                      (item.data![index].duration! > 600)) {
                    newIndex = item.data![index];
                    return GestureDetector(
                      onTap: () {
                        print(item.data![index].albumId);
                      },
                      child: ListTile(
                        title: Text(item.data![index].title),
                        subtitle: Text(item.data![index].displayName),
                        trailing: const Icon(Icons.more_vert),
                        leading: QueryArtworkWidget(
                          id: item.data![index].id,
                          // frameBuilder: (p0, p1, p2, p3) {
                          //   return DecoratedBox(
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       border: Border.all(),
                          //       borderRadius: BorderRadius.circular(20),
                          //     ),
                          //     child: Image.network(
                          //       'https://flutter.github.io/assets-for-api-docs/assets/widgets/puffin.jpg',
                          //       frameBuilder: (BuildContext context,
                          //           Widget child,
                          //           int? frame,
                          //           bool wasSynchronouslyLoaded) {
                          //         if (wasSynchronouslyLoaded) {
                          //           return child;
                          //         }
                          //         return AnimatedOpacity(
                          //           child: child,
                          //           opacity: frame == null ? 0 : 1,
                          //           duration: const Duration(seconds: 1),
                          //           curve: Curves.easeOut,
                          //         );
                          //       },
                          //     ),
                          //   );
                          // },

                          nullArtworkWidget: Image.asset(
                            "assets/images/2pac.jpg",
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                          type: ArtworkType.AUDIO,
                        ),
                      ),
                    );
                  }
                  return Container();
                });
          },
        ));
  }
}
