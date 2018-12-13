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

  var _botIdController = new TextEditingController();

  BotPageState(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewModel.bot.name),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Edit bot ID",
            onPressed: _showBotIdDialog,
          )
        ]
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

  void _showBotIdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _botIdController.text = _viewModel.botId;
        
        return AlertDialog(
          title: Text("Edit Bot ID"),
          content: TextField(
            autofocus: true,
            controller: _botIdController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () => Navigator.of(context).pop()
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                _viewModel.botId = _botIdController.text;
                Navigator.of(context).pop();
              }
            )
          ],
        );
      }
    );
  }

}