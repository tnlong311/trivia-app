import 'package:flutter/material.dart';
import 'package:trivia_app/services/user_service.dart';
import 'package:trivia_app/views/widgets/Layer.dart';
import 'package:trivia_app/views/widgets/TextFieldWithButton.dart';
import 'dart:math';

import '../dialogs/custom_snackbar.dart';
import 'lobby_page.dart';

class TeamFormationPage extends StatefulWidget {
  static const routeName = "/team-formation";

  const TeamFormationPage({Key? key}) : super(key: key);

  @override
  State<TeamFormationPage> createState() => _TeamFormationPageState();
}

class _TeamFormationPageState extends State<TeamFormationPage>
    with TickerProviderStateMixin {
  late AnimationController anime;
  late Animation movement, movement2;
  var _name = 'STEMer';

  @override
  void initState() {
    super.initState();
    anime =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    movement = Tween(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: anime, curve: Curves.elasticInOut));

    movement2 = Tween(
      begin: 0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: anime, curve: Curves.easeInOutCubic));
  }

  void run_animation() {
    anime.reset();
    anime.forward();
  }

  @override
  void didUpdateWidget(TeamFormationPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    anime.duration = const Duration(seconds: 4);
  }

  @override
  void dispose() {
    anime.dispose();
    super.dispose();
  }

  inputValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 4 || value.length > 30) {
      return 'Must between 4-30 chars';
    }

    return null;
  }

  inputUpdator(value) async {
    var pin = await RtdbUserService.getCurrentUserPin();

    if (pin.toString() == '') {
      return false;
    } else {
      setState(() {
        _name = value;
      });
      await RtdbUserService.setName(pin.toString(), value);
      print('Set group name $value with pin $pin');
      return true;
    }
  }

  Future<void> nextPage() async {
    CustomSnackBar.showSuccessSnackBar(context, 'Welcome, $_name!');
    run_animation();
    await Future.delayed(const Duration(milliseconds: 1500));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    await Future.delayed(const Duration(milliseconds: 300));

    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const LobbyPage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero));
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final viewHeight = MediaQuery.of(context).size.height;
    final viewWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: false,
      child: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Stack(children: <Widget>[
              Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              const Layer(),
              AnimatedBuilder(
                  animation: anime,
                  builder: (context, _) {
                    final d = movement2.value.toDouble();
                    return Positioned(
                      top: 0,
                      right: (viewWidth - 400) / 2.0 + d * 350,
                      child: Container(
                        color: Colors.transparent,
                        width: 400,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.white.withOpacity(-d + 1),
                                fontWeight: FontWeight.w800,
                                fontFamily: 'PixelFont',
                                letterSpacing: 0.6,
                                fontSize: 50,
                                height: 2,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: const Offset(4.0, 4.0),
                                    blurRadius: 1.0,
                                    color: const Color.fromARGB(255, 232, 27, 119)
                                        .withOpacity(-d + 1),
                                  ),
                                  Shadow(
                                    offset: const Offset(-4.0, -4.0),
                                    blurRadius: 1.0,
                                    color: const Color.fromARGB(255, 67, 230, 244)
                                        .withOpacity(-d + 1),
                                  ),
                                ],
                                decoration: TextDecoration.none,
                              ),
                              text: "How can we call your group?"),
                        ),
                      ),
                    );
                  }),
              AnimatedBuilder(
                  animation: anime,
                  builder: (context, _) {
                    final d = movement2.value.toDouble();
                    return Positioned(
                      top: 0,
                      left: (viewWidth - viewWidth / 1.2) / 2.0 + (1 - d) * 350,
                      child: Container(
                        color: Colors.transparent,
                        width: viewWidth / 1.2,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.white.withOpacity(d),
                                fontWeight: FontWeight.w800,
                                fontFamily: 'PixelFont',
                                letterSpacing: 0.6,
                                fontSize: 50,
                                height: 2,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: const Offset(4.0, 4.0),
                                    blurRadius: 1.0,
                                    color: const Color.fromARGB(255, 232, 27, 119)
                                        .withOpacity(d),
                                  ),
                                  Shadow(
                                    offset: const Offset(-4.0, -4.0),
                                    blurRadius: 1.0,
                                    color: const Color.fromARGB(255, 67, 230, 244)
                                        .withOpacity(d),
                                  ),
                                ],
                                decoration: TextDecoration.none,
                              ),
                              text: "Waiting for host..."),
                        ),
                      ),
                    );
                  }),
              AnimatedBuilder(
                  animation: anime,
                  builder: (context, _) {
                    final mv = movement2.value.toDouble();
                    return Positioned(
                        top:viewHeight * 2.0 / 4.0 -
                            max(
                                0,
                                MediaQuery.of(context).viewInsets.bottom -
                                    viewHeight +
                                    viewHeight * 2.0 / 4.0 +
                                    120),
                        left: (viewWidth - (-mv * 200 + 300 * 0.8)) / 2.0,
                        child: Container(
                          width: -mv * 200 + 300,
                          child: TextFieldWithButton(
                            nextPage: nextPage,
                            run_animation: run_animation,
                            validator: inputValidator,
                            updator: inputUpdator,
                            routeName: LobbyPage.routeName,
                            failMsg: 'An error has occured',
                            hintText: 'Your group name',
                            width: 300,
                            height: 80,
                            successMsg: 'Welcome, $_name!',
                          ),
                        ));
                  }),
              AnimatedBuilder(
                  animation: anime,
                  builder: (context, _) {
                    var p1 = Image.asset(
                      'assets/images/planet.png',
                      fit: BoxFit.cover,
                    );
                    final mv = movement.value.toDouble();
                    final diff = viewWidth * 1.7 - viewWidth / 1.1;
                    return Positioned(
                        top: viewHeight / 1.35,
                        left: (viewWidth - viewWidth * 1.7 + diff * mv) / 2.0,
                        child: Container(
                            width: -mv * diff + viewWidth * 1.7,
                            child: Transform.translate(
                              offset: Offset(0, mv * -viewHeight / 3),
                              child: Transform.rotate(
                                  angle: -2.0 / 3.0 * pi * 1 + pi * 0.4,
                                  child: p1),
                            )));
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
