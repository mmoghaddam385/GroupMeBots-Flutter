import 'dart:async';

import 'package:groupme_bots/model/Bot.dart';
import 'package:groupme_bots/model/BotMessage.dart';
import 'package:groupme_bots/usecase/GroupMeMessageUseCase.dart';

class BotPageViewModel {
  
  Bot bot;

  var _messageSink = StreamController<BotMessage>.broadcast();
  
  String get botId => groupMeMessageUseCase.botId;
  set botId (String botId) => groupMeMessageUseCase.botId = botId;

  BotPageViewModel(this.bot);

  Stream<BotMessage> getMessageStream() => _messageSink.stream;

  void sendMessage(String message) {
    _messageSink.add(BotMessage(
      text: message,
      state: BotMessageState.PENDING,
      timeStamp: DateTime.now()
    ));
    
    print("Sending message: $message");

    groupMeMessageUseCase.postMessage(message).then(
      (status) => print("Status code: $status")
    ).catchError(
      (error) => print("Error! $error")
    );
  }

  void dispose() {
    _messageSink.close();
  }
}