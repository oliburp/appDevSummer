import '/import/export.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.email});

  final String email;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginEmail');
    await prefs.remove('signupEmail');
    showToast('Logged out successfully');
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyLogin(),
        ),
      );
    }
  }

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
      body: Column(
        children: [
          MyButton(
            height: 40,
            text: 'Logout',
            onTap: signOut,
          ),
          Text(
            widget.email,
            style: const TextStyle(color: Color.fromARGB(255, 5, 236, 143)),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarTheme(
        data: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedLabelStyle: TextStyle(color:  Color.fromARGB(255, 5, 236, 143)),
          selectedItemColor: Color.fromARGB(255, 5, 236, 143)
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
