import '/import/export.dart';

class MyHome extends StatefulWidget {
  const MyHome({
    super.key,
  });

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: songList.length,
          itemBuilder: (BuildContext context, int index) {
            final song = songList[index];
            final isFavorite = favoriteList.contains(song);

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
                    favoriteList.add(songList[index]);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? const Color.fromARGB(255, 5, 236, 143)
                        : null,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyPlayer(initialIndex: index,songList: songList,)),
                  );
                },
              ),
            );
          }),
    );
  }
}
