import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'games/hold_it/hold_it_bloc.dart';
import 'games/stop_it/stop_it_bloc.dart';
import 'games/tapme/tapme_bloc.dart';

class RootBlocScope extends StatelessWidget {
  final Widget child;

  const RootBlocScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TapMeBloc>(create: (_) => TapMeBloc()),
        BlocProvider<StopItBloc>(create: (_) => StopItBloc()),
        BlocProvider<HoldItBloc>(create: (_) => HoldItBloc()),
      ],
      child: child,
    );
  }
}
