import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isRememberMe = true;

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
    } else {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // enregistrer le choix de l'utilisateur
      await prefs.setBool('rememberMe', isRememberMe);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Connexion réussie')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        /*(route) => false,*/
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          title: const Text('Page de connexion'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //espace
                const SizedBox(height: 80),
                // icon de connexion
                Icon(Icons.lock, size: 120, color: Colors.grey),
                const SizedBox(height: 20), // espace
                // champ de saisie de l'adresse email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 20),

                // champ de saisie du mot de passe
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // case à cocher "Se souvenir de moi"
                Row(
                  children: [
                    Radio(
                      value: isRememberMe,
                      groupValue: true,
                      onChanged: (b) {
                        setState(() async {
                          isRememberMe = !isRememberMe;
                        });
                      },
                      toggleable: true,
                      activeColor: Colors.deepPurple,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isRememberMe = !isRememberMe;
                        });
                      },
                      child: Text('Se souvenir de moi'),
                    ),
                  ],
                ),
                const SizedBox(height: 80),

                // bouton de connexion
                GestureDetector(
                  onTap: () {
                    login(
                      context,
                      emailController.text,
                      passwordController.text,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.35,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
