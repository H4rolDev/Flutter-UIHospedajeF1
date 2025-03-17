import 'package:flutter/material.dart';
import 'package:flutter_hospedajef1/presentation/screens/finalizarLimpieza.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:async';

class LimpiezaEnProceso extends StatefulWidget {
  @override
  _LimpiezaEnProcesoState createState() => _LimpiezaEnProcesoState();
}

class _LimpiezaEnProcesoState extends State<LimpiezaEnProceso> {
  late String horaInicio;
  late String fechaInicio;
  int segundosTranscurridos = 0;
  Timer? _timer;
  List<Uint8List> imagenes = [];

  @override
  void initState() {
    super.initState();
    DateTime ahora = DateTime.now();
    fechaInicio = DateFormat('dd/MM/yy').format(ahora);
    horaInicio = DateFormat('hh:mm a').format(ahora);
    _iniciarContador();
  }

  void _iniciarContador() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        segundosTranscurridos++;
      });
    });
  }

  String _formatearTiempo(int segundos) {
    int minutos = segundos ~/ 60;
    int seg = segundos % 60;
    return '${minutos.toString().padLeft(2, '0')} : ${seg.toString().padLeft(2, '0')}';
  }

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? seleccionada = await picker.pickImage(source: ImageSource.gallery);
    
    if (seleccionada != null) {
      Uint8List bytes = await seleccionada.readAsBytes();
      setState(() {
        if (imagenes.length < 5) {
          imagenes.add(bytes);
        }
      });
    }
  }

  void _eliminarImagen(int index) {
    setState(() {
      imagenes.removeAt(index);
    });
  }

  void _mostrarDialogoRetroceso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.orangeAccent.shade100,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '¿Está seguro de cancelar la limpieza de esta habitación?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No', style: TextStyle(color: Colors.orange)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Sí', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarDialogoFinalizarLimpieza() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.redAccent.shade100,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Está a punto de finalizar la limpieza.\n¿Está seguro de esta acción?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      DateTime horaFin = DateTime.now();
                      int minutosTotales = segundosTranscurridos ~/ 60;

                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinalizarLimpieza(
                            horaInicio: horaInicio,
                            horaFin: DateFormat('hh:mm a').format(horaFin),
                            minutosTotales: minutosTotales,
                          ),
                        ),
                      );
                    },
                    child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descripción de Habitación', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _mostrarDialogoRetroceso,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Información de la habitación
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.meeting_room, color: Colors.black54),
                      SizedBox(width: 8),
                      Text('Habitación 103', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Habitación matrimonial con cama de dos plazas y media, 1 juego de sábanas negras Okaeri de 2 plazas, '
                    '2 almohadas con sus fundas, 2 toallas, 1 silla, piso sensible a fuertes ácidos, cortinas térmicas color gris.',
                    style: TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  Text('Hora de inicio', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('$fechaInicio\n$horaInicio', style: TextStyle(color: Colors.black87)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Temporizador
            const Text('Tiempo transcurrido', style: TextStyle(fontWeight: FontWeight.bold)),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black54,
              child: Text(
                '${(segundosTranscurridos ~/ 60).toString().padLeft(2, '0')} : ${(segundosTranscurridos % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Observaciones
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Observaciones', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(12),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),

            // Fotos de las observaciones
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Fotos de las observaciones', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int i = 0; i < imagenes.length; i++)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          imagenes[i],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _eliminarImagen(i),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(Icons.close, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),

                if (imagenes.length < 5)
                  GestureDetector(
                    onTap: _seleccionarImagen,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black54, width: 1),
                      ),
                      child: const Icon(Icons.add, size: 40, color: Colors.black54),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // Botón Finalizar Limpieza
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
              ),
              onPressed: _mostrarDialogoFinalizarLimpieza, // No se toca el botón de finalizar limpieza
              child: const Text('Finalizar Limpieza', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
