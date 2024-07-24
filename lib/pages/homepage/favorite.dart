import '/import/export.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  void initState() {
    super.initState();
    loadFavorites();
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
    return SingleChildScrollView(
      child: favoriteList.isEmpty
          ? const Center(
              child: Text(
              'Favorites is currently empty, add some!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ))
          : ListView.builder(
              shrinkWrap: true,
              itemCount: favoriteList.length,
              itemBuilder: (BuildContext context, int index) {
                final song = favoriteList[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(song[0],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(song[1],
                        style: const TextStyle(
                            color: Color.fromARGB(150, 255, 255, 255))),
                    leading: Image.asset(song[2]),
                    trailing: IconButton(
                        onPressed: () {
                          toggleFavorite(song[0]);
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Color.fromARGB(255, 5, 236, 143),
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyPlayer(
                                song: song[0],
                                artist: song[1],
                                img: song[2],
                                route: song[3])),
                      );
                    },
                  ),
                );
              }),
    );
  }
}
