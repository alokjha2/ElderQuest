import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final volume = useState(0.75);
    final resolution = useState(0.6);
    final maxFps = useState(0.65);
    final musicOn = useState(true);
    final darkMode = useState(false);
    final vibrationOn = useState(true);
    final adsOn = useState(true);

    return Scaffold(
      backgroundColor: const Color(0xFFF8E8DD),
      body: SafeArea(
        child: Column(
          children: [
            const _HeaderBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(title: 'Volume'),
                    _SliderRow(
                      value: volume.value,
                      onChanged: (v) => volume.value = v,
                    ),
                    const SizedBox(height: 18),
                    _ToggleRow(
                      label: 'Music',
                      value: musicOn.value,
                      onChanged: (v) => musicOn.value = v,
                    ),
                    const SizedBox(height: 12),
                    _ToggleRow(
                      label: 'Dark Mode',
                      value: darkMode.value,
                      onChanged: (v) => darkMode.value = v,
                    ),
                    const SizedBox(height: 12),
                    _ToggleRow(
                      label: 'Vibration',
                      value: vibrationOn.value,
                      onChanged: (v) => vibrationOn.value = v,
                    ),
                    const SizedBox(height: 12),
                    _ToggleRow(
                      label: 'Targeted Ads',
                      value: adsOn.value,
                      onChanged: (v) => adsOn.value = v,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionTitle(title: 'Resolution'),
                              _SliderRow(
                                value: resolution.value,
                                onChanged: (v) => resolution.value = v,
                              ),
                              const SizedBox(height: 18),
                              _SectionTitle(title: 'Maximum FPS'),
                              _SliderRow(
                                value: maxFps.value,
                                onChanged: (v) => maxFps.value = v,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        _FpsCard(value: 54),
                      ],
                    ),
                    const SizedBox(height: 22),
                    _SectionTitle(title: 'Language'),
                    const SizedBox(height: 8),
                    const _LanguageButton(),
                    const SizedBox(height: 28),
                    const _FooterText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2B9A5), width: 2),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFD17C6E)),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'SETTINGS',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  letterSpacing: 1.2,
                  color: Color(0xFFD17C6E),
                ),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF4A4A4A),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _SliderRow({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8,
        activeTrackColor: const Color(0xFFB86E8E),
        inactiveTrackColor: const Color(0xFFE8C9D6),
        thumbColor: const Color(0xFF9C5AA7),
        overlayColor: const Color(0x339C5AA7),
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            width: 58,
            height: 30,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: value ? const Color(0xFFD9B1D0) : const Color(0xFFD7D7D7),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Align(
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: value ? const Color(0xFF9C5AA7) : const Color(0xFF6A6A6A),
                  shape: BoxShape.circle,
                ),
                child: value
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FpsCard extends StatelessWidget {
  final int value;

  const _FpsCard({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFFE7BDA8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: Text(
              '$value\nFPS',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Color(0xFFB76D53),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 18,
            child: Transform.rotate(
              angle: 0.2,
              child: const Icon(Icons.change_history, size: 20, color: Color(0xFF5A3D33)),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 18,
            child: Transform.rotate(
              angle: -0.3,
              child: const Icon(Icons.change_history, size: 20, color: Color(0xFF5A3D33)),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF9C5AA7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.language, color: Colors.white, size: 20),
          SizedBox(width: 8),
          Text(
            'System\nLanguage',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterText extends StatelessWidget {
  const _FooterText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF8C6F61),
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(text: 'Our '),
            TextSpan(
              text: 'Terms and Privacy Policy.',
              style: TextStyle(color: Color(0xFF9C5AA7)),
            ),
          ],
        ),
      ),
    );
  }
}
