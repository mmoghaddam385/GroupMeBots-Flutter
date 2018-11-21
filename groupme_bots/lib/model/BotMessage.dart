

import 'package:meta/meta.dart';

@immutable class BotMessage {

  final String text;
  final BotMessageState state;
  final DateTime timeStamp;

  BotMessage({@required this.text, @required this.state, @required this.timeStamp});

}

enum BotMessageState {
  PENDING, SENT, FAILED
}