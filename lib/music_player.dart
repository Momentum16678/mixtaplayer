import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicPlayer extends StatefulWidget {
  final SongModel songModel;
  final AudioPlayer audioPlayer;
  @override
  const MusicPlayer(
      {super.key, required this.songModel, required this.audioPlayer});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isPlaying = false;
  //final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playSong();
  }

  void playSong() {
    try {
      widget.audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
      widget.audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log("Cannot parse song");
    }
    widget.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0E0116),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white)),
        title: Text(
             'Now Playing',
             style: TextStyle(color: Colors.white)
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0E0116), Color(0xFF300347), Color(0xFF0E0116)],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          SizedBox(height: 50,),
          CircleAvatar(
            radius: 100.0,
            child: Icon(
              Icons.music_note,
              size: 60.0,
            ),
            // backgroundImage: widget.songModel.album == null
            //   ? AssetImage('assets/images/music_gradient.jpg') as ImageProvider
            // : FileImage(File(widget.songModel.displayName)),
            // radius: 75,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              widget.songModel.displayNameWOExt,
              overflow: TextOverflow.fade,
              maxLines: 3,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 33),
            child: Text(
              widget.songModel.artist.toString() == "unknown"
                  ? "Unknown Artist"
                  : widget.songModel.artist.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
            child: Row(
              children: [
                Text(
                  _position.toString().split(".")[0],
                    style: TextStyle(color: Colors.white)
                ),
                Expanded(
                  child: Slider(
                    min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changeToSeconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                ),
                Text(
                  style: TextStyle(color: Colors.white),
                  _duration.toString().split(".")[0]
                ),
              ]
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: (){},
                  icon: Icon(
                      Icons.skip_previous,
                      size: 55,
                      color: Colors.white,
                  )
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (_isPlaying) {
                      widget.audioPlayer.pause();
                    } else {
                      widget.audioPlayer.play();
                    }
                    _isPlaying = !_isPlaying;
                  });
                },
                icon: Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled_rounded
                        : Icons.play_circle_fill_rounded,
                    color: Colors.white,
                    size: 55),
              ),
              IconButton(onPressed: (){},
                  icon: Icon(
                    Icons.skip_next,
                    size: 55,
                    color: Colors.white,
                  )
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void changeToSeconds(int seconds){
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
  
}
