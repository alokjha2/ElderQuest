import 'package:elder_quest/application/games/tapme/tapme_bloc.dart';
import 'package:elder_quest/application/games/tapme/tapme_event.dart';
import 'package:elder_quest/application/games/tapme/tapme_state.dart';
import 'package:elder_quest/domain/games/tapme/tapme_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/component/game_page_card.dart';
import '../shared/end_score/end_score_page.dart';

class TapMePage extends StatelessWidget {
  const TapMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TapMeView();
  }
}

class _TapMeView extends StatelessWidget {
  const _TapMeView();

  @override
  Widget build(BuildContext context) {
    return const _TapMeViewBody();
  }
}

class _TapMeViewBody extends StatefulWidget {
  const _TapMeViewBody();

  @override
  State<_TapMeViewBody> createState() => _TapMeViewBodyState();
}

class _TapMeViewBodyState extends State<_TapMeViewBody>
    with TickerProviderStateMixin {
  final List<_TapBurst> _bursts = [];
  final GlobalKey _bodyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TapMeBloc>().add(TapMeReset());
    });
  }

  @override
  void dispose() {
    for (final burst in _bursts) {
      burst.controller.dispose();
    }
    _bursts.clear();
    super.dispose();
  }

  void _addBurst(Offset position) {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    final burst = _TapBurst(position: position, controller: controller);
    setState(() => _bursts.add(burst));
    controller.forward().whenComplete(() {
      if (!mounted) return;
      setState(() => _bursts.remove(burst));
      controller.dispose();
    });
  }

  void _handleTap(Offset globalPosition) {
    final box = _bodyKey.currentContext?.findRenderObject() as RenderBox?;
    final localPosition =
        box != null ? box.globalToLocal(globalPosition) : globalPosition;
    _addBurst(localPosition);
    final bloc = context.read<TapMeBloc>();
    final status = bloc.state.game.status;
    if (status == TapMeStatus.initial) {
      bloc.add(TapMeStarted());
      bloc.add(TapMeTapped());
      return;
    }
    if (status == TapMeStatus.playing) {
      bloc.add(TapMeTapped());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TapMeBloc, TapMeState>(
        listenWhen: (prev, curr) => prev.game.status != curr.game.status,
        listener: (context, state) {
          if (state.game.status == TapMeStatus.finished) {
            context.go(
              '/end-score',
              extra: EndScoreArgs(
                gameTitle: 'Tap Me!',
                score: state.game.score.value,
                playRoute: '/tapme',
              ),
            );
          }
        },
        child: GamePageCard(
          backgroundColor: AppColors.hintBlue,
          title: 'TAP ME',
          onBack: () => context.pop(),
          onTapDown: (details) => _handleTap(details.globalPosition),
          body: Stack(
            key: _bodyKey,
            children: [
              Center(
                child: BlocBuilder<TapMeBloc, TapMeState>(
                  builder: (context, state) {
                    final game = state.game;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Time: ${game.remainingTime}",
                          style: AppTextStyles.scoreText,
                        ),
                        const SizedBox(height: AppSpacing.s20),
                        Text(
                          "Score: ${game.score.value}",
                          style: AppTextStyles.scoreText,
                        ),
                        const SizedBox(height: AppSpacing.s40),
                        Text(
                          game.status == TapMeStatus.initial
                              ? 'Tap anywhere to start'
                              : 'Tap anywhere',
                          style: AppTextStyles.bodySecondary,
                        ),
                      ],
                    );
                  },
                ),
              ),
              ..._bursts.map((burst) => _TapBurstView(burst: burst)),
            ],
          ),
        ),
    );
  }
}

class _TapBurst {
  final Offset position;
  final AnimationController controller;

  _TapBurst({required this.position, required this.controller});
}

class _TapBurstView extends StatelessWidget {
  final _TapBurst burst;

  const _TapBurstView({required this.burst});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    const plusOffsetY = -30.0;
    final target = Offset(screen.width * 0.5, screen.height * 0.28);
    final startPlus = Offset(burst.position.dx, burst.position.dy + plusOffsetY);
    final drift = Offset(
      (target.dx - startPlus.dx) * 0.35,
      (target.dy - startPlus.dy) * 0.35 + 24,
    );

    final scale = Tween<double>(begin: 0.7, end: 1.25).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: Curves.easeOutBack,
      ),
    );
    final fade = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeOut),
      ),
    );
    final rise = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: Curves.easeOut,
      ),
    );
    final ripple = Tween<double>(begin: 0.4, end: 1.2).animate(
      CurvedAnimation(
        parent: burst.controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );

    return Stack(
      children: [
        Positioned(
          left: burst.position.dx - 24,
          top: burst.position.dy - 24,
          child: _TapRipple(ripple: ripple),
        ),
        Positioned(
          left: startPlus.dx - 24,
          top: startPlus.dy - 24,
          child: AnimatedBuilder(
            animation: burst.controller,
            builder: (context, child) {
              return Opacity(
                opacity: fade.value,
                child: Transform.translate(
                  offset: Offset(
                    drift.dx * burst.controller.value,
                    drift.dy * burst.controller.value + rise.value,
                  ),
                  child: Transform.scale(
                    scale: scale.value,
                    child: child,
                  ),
                ),
              );
            },
            child: const _PlusOne(),
          ),
        ),
      ],
    );
  }
}

class _TapRipple extends StatelessWidget {
  final Animation<double> ripple;

  const _TapRipple({required this.ripple});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ripple,
      builder: (context, child) {
        return Opacity(
          opacity: (1 - ripple.value).clamp(0, 1),
          child: Transform.scale(
            scale: ripple.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _PlusOne extends StatelessWidget {
  const _PlusOne();

  @override
  Widget build(BuildContext context) {
    return Text(
      '+1',
      style: AppTextStyles.titleMedium.copyWith(
        color: AppColors.white,
        fontSize: 22,
      ),
    );
  }
}
