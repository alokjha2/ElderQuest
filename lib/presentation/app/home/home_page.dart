import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _GameTile(
        title: 'Tap Me!',
        subtitle: 'Fast fingers',
        route: '/tapme',
        color: const Color(0xFF2E7BFF),
      ),
      _GameTile(
        title: 'Stop It!',
        subtitle: 'Perfect timing',
        route: '/stop-it',
        color: const Color(0xFF00BFA6),
      ),
      _GameTile(
        title: 'Hold It!',
        subtitle: 'Don’t spill',
        route: '/hold-it',
        color: const Color(0xFFFF8A65),
      ),
      _GameTile(
        title: 'Balance It!',
        subtitle: 'Stay steady',
        route: '/balance-it',
        color: const Color(0xFF7C4DFF),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      appBar: AppBar(bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        height: 4,
        color: const Color(0xFF2E7BFF), // your custom color
      ),
    ),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: .8,
          children: items,
        ),
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  final Color color;

  const _GameTile({
    required this.title,
    required this.subtitle,
    required this.route,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go(route),
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(26),
           border: Border.all(
            color: Colors.white,
            width: 6, 
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
