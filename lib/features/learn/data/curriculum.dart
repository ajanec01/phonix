import 'package:flutter/cupertino.dart';

class Phase1Aspect {
  const Phase1Aspect({
    required this.number,
    required this.title,
    required this.description,
    required this.activityLabel,
    required this.icon,
    required this.parentGuide,
  });
  final int number;
  final String title;
  final String description;
  final String activityLabel;
  final IconData icon;
  final String parentGuide;
}

const List<Phase1Aspect> phase1Aspects = [
  Phase1Aspect(
    number: 1,
    title: 'Environmental Sounds',
    description: 'Listen and respond to sounds in the world around you.',
    activityLabel: 'Listening',
    icon: CupertinoIcons.ear,
    parentGuide:
        'Point out sounds together as you go about your day — a car engine, a dog barking, rain on a window. Ask your child "What do you think made that sound?" before looking.',
  ),
  Phase1Aspect(
    number: 2,
    title: 'Instrumental Sounds',
    description: 'Distinguish between sounds made by different instruments.',
    activityLabel: 'Discrimination',
    icon: CupertinoIcons.music_note,
    parentGuide:
        'Close your eyes together and listen to a sound. Can your child tell you whether it is high or low, long or short, loud or quiet? These contrasts build sharp listening skills.',
  ),
  Phase1Aspect(
    number: 3,
    title: 'Body Percussion',
    description: 'Copy and create rhythm patterns using clapping, tapping and stomping.',
    activityLabel: 'Rhythm',
    icon: CupertinoIcons.hand_raised,
    parentGuide:
        'Clap a short pattern and ask your child to copy it. Start with two claps, then three, then try varying the rhythm. Take turns — let your child lead too.',
  ),
  Phase1Aspect(
    number: 4,
    title: 'Rhythm & Rhyme',
    description: 'Recognise and match words that rhyme.',
    activityLabel: 'Rhyming',
    icon: CupertinoIcons.quote_bubble,
    parentGuide:
        'Rhyming does not come naturally to all children — it takes exposure. Sing nursery rhymes together often. When you read a rhyming book, pause before the last word of a couplet and let your child fill it in.',
  ),
  Phase1Aspect(
    number: 5,
    title: 'Alliteration',
    description: 'Spot words that begin with the same sound — and find the odd one out.',
    activityLabel: 'Starting sounds',
    icon: CupertinoIcons.textformat_abc,
    parentGuide:
        'Play "I spy" with the starting sound rather than the letter name: "I spy something beginning with /s/…" This practises hearing the sound, not naming the letter.',
  ),
  Phase1Aspect(
    number: 6,
    title: 'Voice Sounds',
    description: 'Explore the range of sounds the voice can make — loud, quiet, high, low.',
    activityLabel: 'Voice control',
    icon: CupertinoIcons.mic,
    parentGuide:
        'Make silly voices together. A giant voice (deep and loud), a mouse voice (high and quiet), a robot voice. This builds your child\'s awareness of how sounds are produced.',
  ),
  Phase1Aspect(
    number: 7,
    title: 'Oral Blending & Segmenting',
    description:
        'Hear sounds spoken separately and blend them into a word. Break words back into their individual sounds.',
    activityLabel: 'Blending & segmenting',
    icon: CupertinoIcons.speaker_2,
    parentGuide:
        'Say a simple word in "sound-talk" — for example /c/-/a/-/t/ — and ask your child to blend it into the whole word. Keep a small pause between each sound. Start with three-sound words.',
  ),
];
