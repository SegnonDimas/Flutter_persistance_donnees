import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_persistence_donnees/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Accueil'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLJSxKWA93Qe7kr3-R6l3BJpQd-_et3qRQ5A&s',
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),

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
                GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    // enregistrer le choix de l'utilisateur
                    await prefs.setBool('rememberMe', false);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                    /*login(
                              context,
                              emailController.text,
                              passwordController.text,
                            );*/
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: BoxBorder.all(color: Colors.red.shade700),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Se déconnecter',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ), // bouton de connexion
      ),
    );
  }
}
