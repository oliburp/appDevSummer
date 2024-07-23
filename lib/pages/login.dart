import '/import/export.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool loading = false;
  final formkey = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  void submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      String email = loginEmailController.text;
      String password = loginPasswordController.text;

      User? user = await _auth.logInEmailPassword(email, password);

      showToast('Login Successful');

      setState(() {
        loading = false;
      });

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('loginEmail', user.email.toString());
        if (mounted) {Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              email: loginEmailController.text,
            ),
          ),
        );}
      }
    }
  }

  @override
  void initState() {
    super.initState();
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
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(255, 5, 236, 143),
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Good to see you back!',
                  style: TextStyle(color: Color.fromARGB(255, 5, 236, 143)),
                ),
                const SizedBox(height: 20),
                MyEmail(
                  labelText: 'Email',
                  preIcon: Icons.email,
                  controller: loginEmailController,
                ),
                const SizedBox(height: 20),
                MyPassword(
                    labelText: 'Password',
                    controller: loginPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                Center(
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Color.fromARGB(255, 5, 236, 143))
                      : MyButton(
                          text: 'Login',
                          height: 50,
                          onTap: submit,
                        ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Doesn\'t have an account? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MySignup(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Color.fromARGB(255, 5, 236, 143),
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
