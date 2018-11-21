import 'dart:async';

import 'package:groupme_bots/model/Bot.dart';
import 'package:groupme_bots/model/BotMessage.dart';

class BotPageViewModel {
  
  Bot bot;

  var _messageSink = StreamController<BotMessage>.broadcast();
  
  BotPageViewModel(this.bot);

  Stream<BotMessage> getMessageStream() => _messageSink.stream;

  void sendMessage(String message) {
    _messageSink.add(BotMessage(
      text: message,
      state: BotMessageState.PENDING,
      timeStamp: DateTime.now()
    ));
    
    print("Sending message: $message");
  }

  void dispose() {
    _messageSink.close();
  }
}