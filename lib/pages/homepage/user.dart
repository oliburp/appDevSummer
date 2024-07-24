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
    return Column(
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
      );
  }
}