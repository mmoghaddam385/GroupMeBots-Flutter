import 'package:groupme_bots/model/Bot.dart';

class BotPageViewModel {
  
  Bot bot;
  
  BotPageViewModel(this.bot);

  void sendMessage(String message) {
    print("Sending message: $message");
  }

}