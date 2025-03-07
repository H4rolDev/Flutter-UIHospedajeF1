import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinalizarLimpieza extends StatelessWidget {
  final String horaInicio;
  final String horaFin;
  final int minutosTotales;

  const FinalizarLimpieza({
    Key? key,
    required this.horaInicio,
    required this.horaFin,
    required this.minutosTotales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.cleaning_services, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                "Finalizó la limpieza de la habitación correctamente.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _detalleHora("Inicio", horaInicio),
              _detalleHora("Finalización", horaFin),
              _detalleHora("Tiempo de limpieza", "$minutosTotales minutos"),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst); // Vuelve al inicio
                },
                child: const Text(
                  "Volver al inicio",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detalleHora(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$titulo ➜ ", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(valor, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
