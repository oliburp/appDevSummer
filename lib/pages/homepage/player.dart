import '/import/export.dart';

class MyPlayer extends StatefulWidget {
  const MyPlayer({
    Key? key,
    required this.songList,
    required this.initialIndex,
  }) : super(key: key);

  final List<List> songList;
  final int initialIndex;

  @override
  State<MyPlayer> createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    currentIndex = widget.initialIndex;
    _loadSong();

    _audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      _nextTrack();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _loadSong() async {
    String songUrl = widget.songList[currentIndex][3];
    await _audioPlayer.play(AssetSource(songUrl.substring(7)));
    _playPause();
  }

  void _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _nextTrack() {
    if (currentIndex < widget.songList.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      currentIndex = 0;
    }
    _loadSong();
    _playPause();
  }

  void _previousTrack() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    } else {
      currentIndex = widget.songList.length - 1;
    }
    _loadSong();
    _playPause();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = widget.songList[currentIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 28, 24),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        foregroundColor: const Color.fromARGB(255, 5, 236, 143),
        title: const Text('Patogtog',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 24, 28, 24),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color.fromARGB(100, 5, 236, 143)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(100, 2, 126, 76),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        child: Image.asset(currentSong[2],
                            width: double.infinity, fit: BoxFit.fill),
                      ),
                      ListTile(
                        title: Text(currentSong[0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(currentSong[1]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _formatTime(position),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SliderTheme(
                    data: const SliderThemeData(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 0),
                        activeTrackColor: Color.fromARGB(150, 5, 236, 143),
                        inactiveTrackColor: Color.fromARGB(100, 0, 0, 0)),
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await _audioPlayer.seek(position);
                        await _audioPlayer.resume();
                      },
                    ),
                  ),
                  Text(
                    _formatTime(duration),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyPlayerButtons(
                    width: 70,
                    icon: Icons.skip_previous,
                    onPressed: _previousTrack,
                  ),
                  MyPlayerButtons(
                    width: 150,
                    icon: isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: _playPause,
                  ),
                  MyPlayerButtons(
                    width: 70,
                    icon: Icons.skip_next,
                    onPressed: _nextTrack,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
