import 'package:flutter/cupertino.dart';

IconData aspectIcon(String key) => switch (key) {
      'ear' => CupertinoIcons.ear,
      'music_note' => CupertinoIcons.music_note,
      'hand_raised' => CupertinoIcons.hand_raised,
      'quote_bubble' => CupertinoIcons.quote_bubble,
      'textformat_abc' => CupertinoIcons.textformat_abc,
      'mic' => CupertinoIcons.mic,
      'speaker_2' => CupertinoIcons.speaker_2,
      _ => CupertinoIcons.question_circle,
    };
