import 'package:app_cas_natal/cores.dart';
import 'package:app_cas_natal/src/appuser/appuser_model.dart';
import 'package:flutter/material.dart';

class CardUser extends StatefulWidget {
  final AppUserModel user;
  const CardUser({super.key, required this.user});

  @override
  State<CardUser> createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  final cores = Cores();

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white, 
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: user.avatar != null
                  ? Image.memory(
                    user.avatar!,
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  )
                  : Container(
                    width: 85,
                    height: 85,
                    color: cores.laranja,
                    child: const Icon(Icons.person, size: 50, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                SizedBox(width: 25),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 22,
                          color: cores.azulEscuro,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      SizedBox(height: 12),
                      
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoItem("Usuário:", "@${user.userName}"),
                                const SizedBox(height: 6),
                                _buildInfoItem("Email:", user.email),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label ",
            style: TextStyle(
              color: cores.azulEscuro,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}