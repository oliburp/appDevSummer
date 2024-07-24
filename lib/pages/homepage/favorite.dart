import '/import/export.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({super.key});

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  List<Color> iconColors = List.generate(
      favoriteList.length, (index) => const Color.fromARGB(255, 5, 236, 143));

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
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(favoriteList[index][0],
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(favoriteList[index][1],
                        style: const TextStyle(
                            color: Color.fromARGB(150, 255, 255, 255))),
                    leading: Image.asset(favoriteList[index][2]),
                    trailing: IconButton(
                        onPressed: () {
                          favoriteList.remove(favoriteList[index]);
                          setState(() {
                            iconColors[index] = iconColors[index] ==
                                    const Color.fromARGB(255, 5, 236, 143)
                                ? const Color.fromARGB(75, 255, 255, 255)
                                : const Color.fromARGB(255, 5, 236, 143);
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: iconColors[index],
                        )),
                  ),
                );
              }),
    );
  }
}
