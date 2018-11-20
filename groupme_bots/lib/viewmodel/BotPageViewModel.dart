import 'dart:async';

import 'package:groupme_bots/model/Bot.dart';

class BotPageViewModel {
  
  Bot bot;

  var _messageSink = StreamController<String>.broadcast();
  
  BotPageViewModel(this.bot);

  Stream<String> getMessageStream() => _messageSink.stream;

  void sendMessage(String message) {
    _messageSink.add(message);
    print("Sending message: $message");
  }

  void dispose() {
    _messageSink.close();
  }
}