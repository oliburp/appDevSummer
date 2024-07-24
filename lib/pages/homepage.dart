import '/import/export.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.email});

  final String email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 28, 24),
      appBar: AppBar(
        title: const Text(
          'Patogtog',
          style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 5, 236, 143),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: <Widget>[
        const MyHome(),
        const MyFavorites(),
        MyUser(email: widget.email,),
      ][currentPageIndex],
      bottomNavigationBar: BottomNavigationBarTheme(
        data: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedLabelStyle: TextStyle(color:  Color.fromARGB(255, 5, 236, 143)),
          selectedItemColor: Color.fromARGB(255, 5, 236, 143)
        ),
        child: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          currentIndex: currentPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
