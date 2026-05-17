import 'package:flutter/cupertino.dart';
import '../../../theme/app_colors.dart';

class PhaseInfo {
  const PhaseInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.about,
    required this.learningGoals,
    required this.tipsForHome,
  });
  final int id;
  final String title;
  final String description;
  final Color color;
  final String about;
  final List<String> learningGoals;
  final List<String> tipsForHome;
}

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

const List<PhaseInfo> phases = [
  PhaseInfo(
    id: 1,
    title: 'Phase 1',
    description: 'Listening, rhythm and blending spoken sounds. No letters yet — all oral.',
    color: AppColors.phase1,
    about: 'Before children learn letter sounds, they need to develop a sharp ear. Phase 1 builds listening skills, rhythm, and the ability to hear individual sounds in spoken words — all through play.',
    learningGoals: [
      'Tune in to sounds in the environment',
      'Develop a sense of rhythm and rhyme',
      'Hear individual sounds in words',
      'Blend spoken sounds into words',
    ],
    tipsForHome: [
      'Narrate sounds on a walk — "I can hear a bird, can you?"',
      'Sing nursery rhymes together every day',
      'Play "I spy" using sounds, not letters: "/s/ for something I can see…"',
      'Clap the words in a sentence: "Fish and chips" — three claps',
      'Read aloud often and pause to let your child predict the rhyming word',
    ],
  ),
  PhaseInfo(
    id: 2,
    title: 'Phase 2',
    description: 'First 19 letter sounds and reading short words like sat, tap and pin.',
    color: AppColors.phase2,
    about: 'Phase 2 introduces the first 19 letter sounds (grapheme-phoneme correspondences). Children learn to blend sounds to read simple CVC words and begin segmenting to spell.',
    learningGoals: [
      'Learn the first 19 letter sounds',
      'Blend sounds to read simple words',
      'Segment words to begin spelling',
      'Read and spell some tricky words',
    ],
    tipsForHome: [
      'Practise one or two sounds a day — little and often works best',
      'When reading together, point to each letter sound and blend slowly',
      'Play "What word am I making?" — say the sounds and let your child blend',
      'Praise the attempt, not just the correct answer',
    ],
  ),
  PhaseInfo(
    id: 3,
    title: 'Phase 3',
    description: 'Digraphs and vowel combinations — ch, sh, ai, ee, oo and more.',
    color: AppColors.phase3,
    about: 'Phase 3 completes the alphabet and introduces digraphs — two letters that make one sound. Children learn vowel digraphs like ai, ee, igh and oo, and start reading more complex words.',
    learningGoals: [
      'Learn digraphs: ch, sh, th, ng, qu',
      'Learn vowel digraphs: ai, ee, igh, oa, oo, ar, or, ur, ow, oi, ear, air',
      'Read and write sentences',
      'Learn more tricky words',
    ],
    tipsForHome: [
      'Point out digraphs on signs and packaging — they\'re everywhere',
      'Read simple decodable books together every day',
      'Ask your child to sound out unfamiliar words rather than guessing from pictures',
      'Make it a game — who can spot a word with \'oo\' first?',
    ],
  ),
  PhaseInfo(
    id: 4,
    title: 'Phase 4',
    description: 'Reading and spelling longer words with consonant clusters.',
    color: AppColors.phase4,
    about: 'Phase 4 consolidates what children know and focuses on reading and spelling longer words that contain adjacent consonants — clusters like \'st\', \'tr\', \'str\' and \'nk\'.',
    learningGoals: [
      'Read and spell words with consonant clusters',
      'Read and write longer sentences',
      'Develop fluency with known grapheme-phoneme correspondences',
      'Expand the bank of tricky words',
    ],
    tipsForHome: [
      'Encourage your child to tackle longer words by breaking them into chunks',
      'Re-read favourite books to build fluency and confidence',
      'Play spelling games with consonant cluster words',
      'Write shopping lists or notes together',
    ],
  ),
  PhaseInfo(
    id: 5,
    title: 'Phase 5',
    description: 'Alternative spellings and pronunciations — the same sound, many ways to write it.',
    color: AppColors.phase5,
    about: 'Phase 5 broadens children\'s knowledge of graphemes. They learn that a sound can be spelled in different ways (ai, ay, a-e) and that the same spelling can have different sounds (ow in \'cow\' vs \'blow\').',
    learningGoals: [
      'Learn alternative graphemes for known phonemes',
      'Choose the correct spelling for common words',
      'Read phonically decodable texts with increasing fluency',
      'Learn more exception words',
    ],
    tipsForHome: [
      'When your child misspells a word, show them the alternatives — \'that sound can also be written as…\'',
      'Read a variety of books to expose them to different words',
      'Play \'how many ways can we spell that sound?\'',
      'Encourage writing — letters, stories, anything',
    ],
  ),
  PhaseInfo(
    id: 6,
    title: 'Phase 6',
    description: 'Reading fluency, spelling rules, suffixes and longer texts.',
    color: AppColors.phase6,
    about: 'By Phase 6, most children can read with increasing fluency and focus shifts to spelling. They learn spelling rules, suffixes, prefixes, and strategies for tackling unfamiliar words in longer texts.',
    learningGoals: [
      'Apply spelling rules consistently',
      'Use prefixes and suffixes correctly',
      'Read longer texts with fluency and comprehension',
      'Develop independent writing skills',
    ],
    tipsForHome: [
      'Read chapter books together — take turns reading pages',
      'Encourage your child to proofread their own writing',
      'Discuss the meaning of new words you come across',
      'Make spelling practice low-pressure and short — 5 minutes is enough',
    ],
  ),
];

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
