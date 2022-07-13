import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_go_router_example/repository/repository.dart';
import 'package:go_router/go_router.dart';

class ColorShadeScreen extends StatelessWidget {
  const ColorShadeScreen({
    Key? key,
    required this.index,
    required this.alpha,
  }) : super(key: key);
  final int index;
  final int alpha;

  void _onIncreaseAlpha(BuildContext context) => Router.neglect(
      context,
      () => context
          .go('/colors/$index?alpha=${alpha + 10 >= 255 ? 255 : alpha + 10}'));

  void _onDecreaseAlpha(BuildContext context) => Router.neglect(
      context,
      () => context
          .go('/colors/$index?alpha=${alpha - 10 <= 0 ? 0 : alpha - 10}'));

  @override
  Widget build(BuildContext context) {
    final color = context.read<ColorRepository>().getColorAt(index);
    final name = context.read<ColorRepository>().getColorKeyAt(index);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Color - $name',
        ),
        centerTitle: true,
        automaticallyImplyLeading: kIsWeb ? false : true,
      ),
      body: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, idx) {
          final shade = (idx + 1) * 100;
          return SizedBox(
            height: 70,
            child: ListTile(
              tileColor: color[shade]!.withAlpha(alpha),
              title: Text(
                'This is $name with shade $shade',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('alpha value: $alpha'),
              textColor: color[shade]!.computeLuminance() > 0.3
                  ? Colors.black
                  : Colors.white,
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'increase-alpha-fab',
            onPressed: () => _onIncreaseAlpha(context),
            label: const Text('increase alpha'),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            heroTag: 'decrease-alpha-fab',
            onPressed: () => _onDecreaseAlpha(context),
            label: const Text('decrease alpha'),
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
