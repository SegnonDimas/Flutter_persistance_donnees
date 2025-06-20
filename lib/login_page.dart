import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final String? email;
  final String? password;
  const LoginPage({super.key, this.email, this.password});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isRememberMe = true;
  rechargeInformations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // récupérer le choix de l'utilisateur
    isRememberMe = prefs.getBool('rememberMe') ?? true;
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
    phoneController.text = prefs.getString('phone') ?? '';
  }

  //suppression des informations de connexion
  Future<void> clearLoginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('phone');
    await prefs.remove('rememberMe');
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
    String phone,
  ) async {
    if (email.isEmpty && phone.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Veuillez remplir au moins votre adresse gmail ou votre numéro de téléphone',
          ),
        ),
      );
    } else if (password.isEmpty) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez saisir votre mot de passe')),
      );
    } else {
      // Obtain shared preferences.
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // enregistrer le choix de l'utilisateur
      await prefs.setBool('rememberMe', isRememberMe);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      await prefs.setString("phone", phone);
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
  void initState() {
    rechargeInformations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                const SizedBox(height: 30),

                // icon de connexion
                CachedNetworkImage(
                  imageUrl:
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8r1TvZrD8224vZqkDaRQ17v5vpU2BWfvBhTHBakKQAD_CBN0LYvGYVVUycbnENaukDWQ&usqp/=CAU12058",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.broken_image_sharp,
                    size: 150,
                    color: Colors.grey.shade400,
                  ),
                ),

                //Icon(Icons.lock, size: 120, color: Colors.grey),
                const SizedBox(height: 20), // espace
                // champ de saisie de l'adresse email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 20),

                // champ de saisie du téléphone
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                ),

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
                      phoneController.text,
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

                // bouton de connexion
                GestureDetector(
                  onTap: () async {
                    await clearLoginData();
                    ;
                  },
                  child: const Text(
                    'Supprimer les informations de connexion',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 16),
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
