import '/import/export.dart';

class MyPlayer extends StatefulWidget {
  const MyPlayer({
    Key? key,
    required this.song,
    required this.artist,
    required this.img,
    required this.route,
  }) : super(key: key);

  final String song;
  final String artist;
  final String img;
  final String route;

  @override
  State<MyPlayer> createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
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
    loadFavorites();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource(widget.route.substring(7)));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void stop() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      position = Duration.zero;
    });
  }

  void loadFavorites() async {
    List<String> favorites = await SharedPrefs.loadFavorites();
    setState(() {
      favoriteList =
          songList.where((song) => favorites.contains(song[0])).toList();
    });
  }

  void toggleFavorite(String songTitle) async {
    List<String> favorites = await SharedPrefs.loadFavorites();
    if (favorites.contains(songTitle)) {
      favorites.remove(songTitle);
    } else {
      favorites.add(songTitle);
    }
    SharedPrefs.saveFavorites(favorites);
    loadFavorites(); // Reload favorites to update the UI
  }

  @override
  Widget build(BuildContext context) {
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
                        child: Image.asset(widget.img,
                            width: double.infinity, fit: BoxFit.fill),
                      ),
                      ListTile(
                        title: Text(widget.song,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(widget.artist),
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
                    formatTime(position),
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
                    formatTime(duration),
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
                    onPressed: () {
                      // Add functionality for skipping to the previous track
                    },
                  ),
                  MyPlayerButtons(
                    width: 150,
                    icon: isPlaying ? Icons.pause : Icons.play_arrow,
                    onPressed: playPause,
                  ),
                  MyPlayerButtons(
                    width: 70,
                    icon: Icons.skip_next,
                    onPressed: () {
                      // Add functionality for skipping to the next track
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
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
