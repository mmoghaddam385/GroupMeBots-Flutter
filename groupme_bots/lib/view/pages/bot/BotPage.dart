import 'package:flutter/material.dart';
import 'package:groupme_bots/model/Bot.dart';
import 'package:groupme_bots/model/BotMessage.dart';
import 'package:groupme_bots/view/Dimens.dart' as dimens;
import 'package:groupme_bots/view/ViewUtils.dart' as ViewUtils;
import 'package:groupme_bots/view/pages/bot/BotMessageView.dart';
import 'package:groupme_bots/view/pages/bot/BotPageMessageBar.dart';
import 'package:groupme_bots/viewmodel/BotPageViewModel.dart';

class BotPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => BotPageState(BotPageViewModel(Bot("Terry Tester", "123")));

}

class BotPageState extends State<BotPage> {
  
  BotPageViewModel _viewModel;

  var _messageController = new TextEditingController();
  var _messages = List();

  BotPageState(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewModel.bot.name)
      ),
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget> [
            Expanded( 
              child: 
                Align(
                  alignment: Alignment.bottomCenter,
                  child:
                    StreamBuilder<BotMessage>(
                      stream: _viewModel.getMessageStream(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          _messages.insert(0, snapshot.data);
                        }
                        return ListView.builder(
                          padding: EdgeInsets.only(top: dimens.GAP_DEFAULT),
                          reverse: true,
                          itemCount: _messages.length,
                          itemBuilder: (context, position) {
                            return BotMessageView(_messages[position]);
                          },
                        );
                      }  
                    )
                )
            ),
            
            BotPageMessageBar(
              messageController: _messageController,
              onMessageSend: () {
                ViewUtils.closeKeyboard(context);
                _viewModel.sendMessage(_messageController.text);
                _messageController.text = "";
              }
            )
          ]
        )
    );
  }

}