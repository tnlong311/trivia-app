import 'package:flutter/cupertino.dart';
import 'package:trivia_app/consts/app_styles.dart';

RichText rules_trivia = RichText(
    text: const TextSpan(style: triviaSmall1, children: <TextSpan>[
  TextSpan(text: 'General\n', style: triviaSmallTitle),
  TextSpan(text: '- All teams start with 32 Dogecoins (DCs)\n'),
  TextSpan(text: '- There will be 20 questions in total.\n'),
  TextSpan(
      text:
          '- To answer a question, (1) submit your answer and (2) make a bet before the time runs out.\n'),
  TextSpan(
      text:
          '- Your team can bet a certain  number of DCs (see next section). If your answer is correct, you will earn DCs equal to the amount bet. Otherwise, you will lose that many DCs.\n'),
  TextSpan(text: '- There will be 20 questions in total.\n'),
  TextSpan(text: 'How to bet?\n', style: triviaSmallTitle),
  TextSpan(
      text:
          '- Before Question 11, you can bet up to half of your current DCs. From Question 11 onwards, you can bet all of your DCs. Tip: Do not bet too much if unsure about your answer.\n'),
  TextSpan(
      text:
          '- All bets must be a positive integer. In case your current score is odd, the maximum bet possible is half of your DCs rounded up. For example, if you have 15 DCs, then you can bet up to 8 DCs.\n'),
  TextSpan(
      text:
          '- Any team with 0 DCs can bet 1 DC and will not be punished for wrong answers.\n'),
  TextSpan(
      text:
          '- Any team with 0 DCs can bet 1 DC and will not be punished for wrong answers.\n')
]));
RichText about_trivia = RichText(
    text: const TextSpan(style: triviaSmall1, children: <TextSpan>[
  TextSpan(text: 'Trivia Night', style: triviaSmallTitle),
  TextSpan(
      text:
          ' is an annual game hosted by Fulbright STEM Club for Fulbright’s community.  The event is to empower STEM education in liberal art context  and create a co-working opportunity for Fulbright STEM club members.\n\nWe hope that you will enjoy the game,\n'),
  TextSpan(text: 'Fulbright STEM club.', style: triviaSmallTitle),
]));
RichText about_app = RichText(
    text: const TextSpan(style: triviaSmall1, children: <TextSpan>[
  TextSpan(
      text:
          'This is a game based-learning platform that adapt to Fulbright Trivia Night which hosts multiple players at one time.'),
  TextSpan(text: '\n\n*Developers '),
  TextSpan(
      text: 'Long Truong (PM), Huy Truong, Khoi Nguyen.',
      style: triviaSmallTitle),
  TextSpan(text: '\n*Designers '),
  TextSpan(text: 'Chi Le and Chau Le.', style: triviaSmallTitle),
]));
