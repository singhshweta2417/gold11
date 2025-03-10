import 'dart:math';
import 'package:flutter/material.dart';

class CustomConfettiScreen extends StatefulWidget {
  const CustomConfettiScreen({super.key});

  @override
  _CustomConfettiScreenState createState() => _CustomConfettiScreenState();
}

class _CustomConfettiScreenState extends State<CustomConfettiScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<ConfettiParticle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {
        for (var particle in particles) {
          particle.update();
        }
      });
    });

    _generateParticles();

    _controller.forward();
  }

  void _generateParticles() {
    final random = Random();
    for (int i = 0; i < 50; i++) {
      particles.add(
        ConfettiParticle(
          x: random.nextDouble() * 400, // Random x position
          y: random.nextDouble() * 600, // Random y position
          color: Color.fromARGB(
            255,
            random.nextInt(256),
            random.nextInt(256),
            random.nextInt(256),
          ), // Random color
          size: random.nextDouble() * 10 + 5, // Random size
          velocityX: random.nextDouble() * 2 - 1, // Random x velocity
          velocityY: random.nextDouble() * 3 + 1, // Random y velocity
          rotationSpeed: random.nextDouble() * 0.1, // Random rotation speed
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Confetti"),
      ),
      body: Stack(
        children: [
          // Confetti painter
          CustomPaint(
            size: Size.infinite,
            painter: ConfettiPainter(particles),
          ),
          // Trigger Button
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                _controller.reset();
                _controller.forward();
              },
              child: const Text("Celebrate!"),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfettiParticle {
  double x, y, size;
  double velocityX, velocityY;
  double rotation = 0;
  double rotationSpeed;
  final Color color;

  ConfettiParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.velocityX,
    required this.velocityY,
    required this.rotationSpeed,
    required this.color,
  });

  void update() {
    x += velocityX;
    y += velocityY;

    // Update rotation
    rotation += rotationSpeed;

    // Add gravity-like effect
    velocityY += 0.05;
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;

  ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var particle in particles) {
      paint.color = particle.color;

      // Save current canvas state
      canvas.save();

      // Rotate canvas for the particle
      canvas.translate(particle.x, particle.y);
      canvas.rotate(particle.rotation);

      // Draw the particle as a rectangle (can customize to shapes like stars or circles)
      canvas.drawRect(
        Rect.fromCenter(
          center: const Offset(0, 0),
          width: particle.size,
          height: particle.size / 2,
        ),
        paint,
      );

      // Restore canvas state
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
