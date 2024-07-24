import '/import/export.dart';

class MyPlayer extends StatelessWidget {
  const MyPlayer(
      {super.key,
      required this.song,
      required this.artist,
      required this.img,
      required this.route});

  final String song;
  final String artist;
  final String img;
  final String route;

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
                        child: Image.asset(img,
                            width: double.infinity, fit: BoxFit.fill),
                      ),
                      ListTile(
                        title: Text(song,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(artist),
                        trailing: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    '0:00',
                    style: TextStyle(color: Colors.white),
                  ),
                  SliderTheme(
                    data: const SliderThemeData(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 0),
                        activeTrackColor: Color.fromARGB(150, 5, 236, 143),
                        inactiveTrackColor: Color.fromARGB(100, 0, 0, 0)),
                    child: Slider(
                        min: 0, max: 100, value: 50, onChanged: (value) {}),
                  ),
                  const Text(
                    '0:00',
                    style: TextStyle(color: Colors.white),
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
                  ),
                  MyPlayerButtons(
                    width: 150,
                    icon: Icons.play_arrow,
                  ),
                  MyPlayerButtons(
                    width: 70,
                    icon: Icons.skip_next,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
