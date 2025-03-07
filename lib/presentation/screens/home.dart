import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/core/colors.dart';
import 'package:flutter_hospedajef1/presentation/widgets/widgetBar.dart';
import '../navigation/app_routes.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgAllScreens,
      appBar: widgetBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text(
              'Escoja un modulo',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed:(){ Navigator.pushNamed(context, AppRoutes.habitaciones);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: 550,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Icon(
                        Icons.cleaning_services_outlined,
                          color: Colors.black,
                          size: 140.0,
                        ),
                      Text(
                        'Registrar habitación de limpieza',
                        style: TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
                
              ),
            ),
            ElevatedButton(
              onPressed:(){ Navigator.pushNamed(context, AppRoutes.habitaciones);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: 550,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Icon(
                        Icons.cleaning_services_outlined,
                          color: Colors.black,
                          size: 140.0,
                        ),
                      Text(
                        'Chatbot',
                        style: TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),
                      )
                    ],
                  ),
                ),
                
              ),
            )
          ],
        ),
      )
    );
  }
}
