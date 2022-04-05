import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/widgets/TextFieldWithButton.dart';

class Layer extends StatefulWidget {
  const Layer({Key? key}) : super(key: key);

  @override
  State<Layer> createState() => _LayerState();
}

class _LayerState extends State<Layer> with SingleTickerProviderStateMixin {
  late AnimationController anime;

  @override
  void initState() {
    super.initState();
    anime =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    anime.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(Layer oldWidget) {
    super.didUpdateWidget(oldWidget);
    anime.duration = const Duration(seconds: 1);
  }

  @override
  void dispose() {
    anime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: anime,
        builder: (context, _) {
          final p1 = Image.asset(
            'assets/images/layer1.png',
            color: Colors.white.withOpacity(anime.value),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          );
          final p2 = Image.asset(
            'assets/images/layer2.png',
            color: Colors.white.withOpacity(1 - anime.value),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          );
          return Stack(
            children: <Widget>[
              Transform(
                transform: Matrix4.identity(),
                child: p1,
              ),
              Transform(
                transform: Matrix4.identity(),
                child: p2,
              ),
            ],
          );
          if (anime.value <= 0.5) {
            return p1;
          } else {
            return p1;
          }
        });
  }
}
