import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'finalizarLimpieza.dart';

class LimpiezaEnProceso extends StatefulWidget {
  @override
  _LimpiezaEnProcesoState createState() => _LimpiezaEnProcesoState();
}

class _LimpiezaEnProcesoState extends State<LimpiezaEnProceso> {
  late String horaInicio;
  late String fechaInicio;
  int segundosTranscurridos = 0;
  Timer? _timer;
  List<File> imagenes = [];

  @override
  void initState() {
    super.initState();
    DateTime ahora = DateTime.now();
    fechaInicio = DateFormat('dd-MM-yyyy').format(ahora);
    horaInicio = DateFormat('hh:mm a').format(ahora);
    _iniciarContador();
  }

  void _iniciarContador() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
    final List<XFile>? seleccionadas = await picker.pickMultiImage();
    if (seleccionadas != null) {
      setState(() {
        if (imagenes.length + seleccionadas.length <= 5) {
          imagenes.addAll(seleccionadas.map((e) => File(e.path)));
        }
      });
    }
  }

  void _eliminarImagen(int index) {
    setState(() {
      imagenes.removeAt(index);
    });
  }

  void _eliminarTodasLasImagenes() {
    setState(() {
      imagenes.clear();
    });
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hora de inicio: $fechaInicio\n$horaInicio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Tiempo transcurrido', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black54,
              child: Text(
                _formatearTiempo(segundosTranscurridos),
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Observaciones', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(onPressed: _seleccionarImagen, child: Text('Subir foto')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _eliminarTodasLasImagenes, child: Text('Eliminar todo')),
              ],
            ),
            Wrap(
              children: imagenes.map((img) {
                int index = imagenes.indexOf(img);
                return Stack(
                  children: [
                    Image.file(img, width: 80, height: 80, fit: BoxFit.cover),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () => _eliminarImagen(index),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _mostrarDialogoFinalizarLimpieza,
              child: const Text('Finalizar Limpieza', style: TextStyle(color: Colors.white)),
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
