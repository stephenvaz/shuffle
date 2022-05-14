import "dart:math";


String test0 = "https://www.hotstar.com/in/tv/modern-family/8549/";
List test = ['pilot/1770001008', 'the-bicycle-thief/1770001011', 'come-fly-with-me/1770001030', 'the-incident/1770001031', 'coal-digger/1770001032', 'run-for-your-wife/1770001033', 'en-garde/1770001034', 'great-expectations/1770001035', 'fizbo/1770001013', 'undeck-the-halls/1770001036', 'up-all-night/1770001037', 'not-in-my-house/1770001038', 'fifteen-percent/1770001039', 'moon-landing/1770001040', 'my-funky-valentine/1770001041', 'fears/1770001042', 'truth-be-told/1770001009', 'starry-night/1770001043', 'game-changer/1770001044', 'benched/1770001010', 'travels-with-scout/1770001045', 'airport-2010/1770001046', 'hawaii/1770001012', 'family-portrait/1770001047'];

String randoMize()  {
  final _random = Random();
  return test0+test[_random.nextInt(test.length)];
}