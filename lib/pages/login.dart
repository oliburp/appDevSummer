// ignore_for_file: prefer_const_constructors

import '/import/export.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  void submit() {
    if (formkey.currentState!.validate()) {
      if (loginEmailController.text.isNotEmpty &&
          loginPasswordController.text.isNotEmpty) {
        showToast('ok');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 28, 24),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(255, 5, 236, 143),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Good to see you back!',
                  style: TextStyle(color: Color.fromARGB(255, 5, 236, 143)),
                ),
                SizedBox(height: 20),
                MyEmail(
                  labelText: 'Email',
                  preIcon: Icons.email,
                  controller: loginEmailController,
                ),
                SizedBox(height: 20),
                MyPassword(
                    labelText: 'Password',
                    controller: loginPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                MyButton(
                  text: 'Login',
                  height: 40,
                  onTap: submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
