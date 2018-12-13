import 'dart:async';

import 'package:groupme_bots/model/Bot.dart';
import 'package:groupme_bots/model/BotMessage.dart';
import 'package:groupme_bots/usecase/GroupMeMessageUseCase.dart';

class BotPageViewModel {
  
  Bot bot;

  var _messageSink = StreamController<BotMessage>.broadcast();
  var _snackBarSink = StreamController<String>.broadcast();
  
  String get botId => groupMeMessageUseCase.botId;
  set botId (String botId) => groupMeMessageUseCase.botId = botId;

  BotPageViewModel(this.bot);

  Stream<BotMessage> getMessageStream() => _messageSink.stream;
  Stream<String> getSnackBarStream() => _snackBarSink.stream;

  void sendMessage(String message) {
    _messageSink.add(BotMessage(
      text: message,
      state: BotMessageState.PENDING,
      timeStamp: DateTime.now()
    ));
    
    print("Sending message: $message");

    groupMeMessageUseCase.postMessage(message).then(
      (status) => print("Status code: $status")
    ).catchError((error) {
        print("Error! $error");
        _snackBarSink.add(error);
      }
    );
  }

  void dispose() {
    _messageSink.close();
    _snackBarSink.close();
  }
}