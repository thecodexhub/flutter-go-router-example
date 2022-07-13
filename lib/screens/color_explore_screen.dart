import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_go_router_example/repository/repository.dart';
import 'package:go_router/go_router.dart';

class ColorExploreScreen extends StatelessWidget {
  const ColorExploreScreen({Key? key}) : super(key: key);

  void _onTap(BuildContext context, int index) {
    GoRouter.of(context).push('/colors/$index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.findAncestorWidgetOfExactType<MaterialApp>()!.title,
        ),
        centerTitle: true,
        automaticallyImplyLeading: kIsWeb ? false : true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
        ),
        itemCount: context.read<ColorRepository>().colorMap?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onTap(context, index),
            child: Container(
              height: 200.0,
              width: 200.0,
              color: context.read<ColorRepository>().getColorAt(index),
              alignment: Alignment.center,
              child: _DescriptionWidget(index: index),
            ),
          );
        },
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Text(
      context.read<ColorRepository>().getColorKeyAt(index),
      style: TextStyle(
        color: context.read<ColorRepository>().computeTextColorFor(index),
      ),
    );
  }
}
