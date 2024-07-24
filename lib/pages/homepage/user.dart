import '/import/export.dart';

class MyUser extends StatefulWidget {
  const MyUser({super.key, required this.email});
  final String email;
  @override
  State<MyUser> createState() => _MyUserState();
}

class _MyUserState extends State<MyUser> {
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 100, 40, 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 250,
              child: Image.asset('assets/logo/logo.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account:',
                  style: TextStyle(
                      color: Color.fromARGB(255, 5, 236, 143), fontSize: 32),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Your email:',
                      style: TextStyle(
                          color: Color.fromARGB(255, 5, 236, 143),
                          fontSize: 24),
                    ),
                const SizedBox(width: 40),
                    Text(
                      widget.email,
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Your favorites:',
                      style: TextStyle(
                          color: Color.fromARGB(255, 5, 236, 143),
                          fontSize: 24),
                    ),
                    
                const SizedBox(width: 10),
                    Text(
                      favoriteList.length.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MyButton(
                  height: 40,
                  text: 'Logout',
                  onTap: signOut,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
