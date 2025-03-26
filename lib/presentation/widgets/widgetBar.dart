import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/data/source/auth_provider.dart';
import 'package:flutter_hospedajef1/core/colors.dart';
import 'package:provider/provider.dart';

class WidgetBar extends StatelessWidget implements PreferredSizeWidget {
  const WidgetBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    String userName = authProvider.employeeData?['name'] ?? "Usuario";
    String userRole = authProvider.employeeData?['role'] ?? "Sin rol";

    return AppBar(
      backgroundColor: AppColors.appBarAllScreens, 
      toolbarHeight: 80,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.notifications, color: Colors.black, size: 24),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                userRole,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
