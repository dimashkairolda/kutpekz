import 'package:flutter/material.dart';
import 'package:kutpekz/auth_provider.dart';
import 'package:kutpekz/pages/loading_page.dart';
import 'package:provider/provider.dart';

    class HomeScreen extends StatefulWidget {
      const HomeScreen({Key? key}) : super(key: key);
      @override
      State<HomeScreen> createState() => _HomeScreenState();
    }
    
    class _HomeScreenState extends State<HomeScreen> {
      @override
      Widget build(BuildContext context) {
        final ap = Provider.of<AuthProvider>(context, listen: false);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text("Kutpe-Kz"),
              actions: [
                IconButton(
                    onPressed: () async {
                      ap.userSignOut().then( (value) => Navigator.of(context)
                          .pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context)=> const LoadingPage()
                          ),
                          ((route) => false)
                        )
                      );
                    },
                    icon: const Icon(Icons.exit_to_app)
                )
              ],
            ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(ap.userModel.profilePicture),
                  radius: 50,
                ),
                const SizedBox(height: 20,),
                Text(ap.userModel.name),
                Text(ap.userModel.phoneNumber),
                Text(ap.userModel.email),
              ],
            ),
          ),
        );
      }
    }
    