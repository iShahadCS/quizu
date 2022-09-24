import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizu/providers/auth.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  const ProfileImage({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: FutureBuilder(
              future: Provider.of<AuthProvider>(context).getUserImage(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Image.asset("assets/icons/profile-image.png");
                } else {
                  return ClipOval(child: Image.memory(snapshot.data));
                }
              },
            )));
  }
}
