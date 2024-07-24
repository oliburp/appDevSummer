import '/import/export.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Color> iconColors = List.generate(
      songList.length, (index) => const Color.fromARGB(75, 255, 255, 255));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: songList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(songList[index][0],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(songList[index][1],
                    style: const TextStyle(
                        color: Color.fromARGB(150, 255, 255, 255))),
                leading: Image.asset(songList[index][2]),
                trailing: IconButton(
                    onPressed: () {
                      favoriteList.add(songList[index]);
                      setState(() {
                        iconColors[index] = iconColors[index] ==
                              const Color.fromARGB(75, 255, 255, 255)
                          ? const Color.fromARGB(255, 5, 236, 143)
                          : const Color.fromARGB(75, 255, 255, 255);
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
