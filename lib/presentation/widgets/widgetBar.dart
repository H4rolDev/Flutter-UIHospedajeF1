import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/core/colors.dart';

class widgetBar extends StatelessWidget implements PreferredSizeWidget {
  const widgetBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarAllScreens, 
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Mueve los elementos a la derecha
          children: [
            Icon(Icons.notifications, color: Colors.black, size: 24), // Icono de campana
            SizedBox(width: 8), // Espacio entre icono y texto
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinea los textos a la izquierda
              children: [
                Text(
                  'Juanito Alimaña',
                  style: TextStyle(
                    color: Colors.black, // Color del texto
                    fontWeight: FontWeight.bold, // Texto en negrita
                    fontSize: 16, // Tamaño del texto
                  ),
                ),
                Text(
                  'Limpieza',
                  style: TextStyle(
                    color: Colors.black, // Color del texto
                    fontSize: 14, // Tamaño más pequeño para la segunda línea
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