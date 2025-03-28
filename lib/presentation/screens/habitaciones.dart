import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/presentation/widgets/widgetBar.dart';
import 'package:flutter_hospedajef1/presentation/navigation/app_routes.dart';

class Habitaciones extends StatefulWidget {
  @override
  _HabitacionesState createState() => _HabitacionesState();
}

class _HabitacionesState extends State<Habitaciones> {
  String? _habitacionSeleccionada;
  Map<String, Color> habitaciones = {
    '101': Colors.red, '102': Colors.yellow, '103': Colors.blue, '104': Colors.blue, '105': Colors.blue, '106': Colors.blue,
    '201': Colors.blue, '202': Colors.red, '203': Colors.blue, '204': Colors.blue, '205': Colors.red, '206': Colors.blue,
    '301': Colors.blue, '302': Colors.red, '303': Colors.blue, '304': Colors.blue, '305': Colors.blue, '306': Colors.blue,
    '401': Colors.blue, '402': Colors.red, '403': Colors.red, '404': Colors.red, '405': Colors.red, '406': Colors.yellow,
    '501': Colors.red, '502': Colors.blue, '503': Colors.red, '504': Colors.red, '505': Colors.blue, '506': Colors.blue,
  };

  void selectHabitacion(String key) {
    if (habitaciones[key] == Colors.yellow || habitaciones[key] == Colors.blue) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La habitación $key no es seleccionable'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _habitacionSeleccionada = key;
      habitaciones.updateAll((_, color) => color == Colors.grey ? Colors.red : color);
      habitaciones[key] = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetBar(),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Limpieza',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              '\ud83c\udfe8 Habitaciones que requieren limpieza',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildHabitaciones(),
            const SizedBox(height: 25),
            buildLeyenda(),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 18),
              ),
              onPressed: _habitacionSeleccionada == null ? null : () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.descripcionHabitacion,
                  arguments: _habitacionSeleccionada,
                );
              },
              child: const Text(
                'Ir a la habitación',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget buildHabitaciones() {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: habitaciones.entries.map((entry) {
        return GestureDetector(
          onTap: () => selectHabitacion(entry.key),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: entry.value,
              border: Border.all(color: Colors.black54, width: 2.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: Text(
              entry.key,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildLeyenda() {
    Map<String, Color> leyenda = {
      'Libre': Colors.white,
      'En limpieza': Colors.yellow,
      'Ocupado': Colors.blue,
      'Por limpiar': Colors.red,
      'Seleccionado': Colors.grey,
    };

    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: leyenda.entries.map((entry) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: entry.value,
                  border: Border.all(color: Colors.black54, width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(entry.key, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          );
        }).toList(),
      ),
    );
  }
}