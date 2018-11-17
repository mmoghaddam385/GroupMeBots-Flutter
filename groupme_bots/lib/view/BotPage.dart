import 'package:flutter/material.dart';
import 'package:groupme_bots/model/Bot.dart';
import 'package:groupme_bots/view/Dimens.dart' as dimens;
import 'package:groupme_bots/view/ViewUtils.dart' as ViewUtils;
import 'package:groupme_bots/viewmodel/BotPageViewModel.dart';

class BotPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => BotPageState(BotPageViewModel(Bot("Terry Tester", "123")));

}

class BotPageState extends State<BotPage> {
  
  BotPageViewModel _viewModel;

  var _messageController = new TextEditingController();

  BotPageState(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewModel.bot.name)
      ),
      body: 
        Padding(
          padding: dimens.ALL_INSETS_DEFAULT,
          child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [ 
                Row(
                  children: <Widget> [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: dimens.GAP_DEFAULT),
                        child: TextField(
                          autofocus: false,
                          controller: _messageController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null, // Lets the view grow vertically as the user types
                          decoration: new InputDecoration(
                            hintText: "What would Geoffrey say?",
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Text("Send"),
                      onPressed: () { 
                        ViewUtils.closeKeyboard(context);
                        _viewModel.sendMessage(_messageController.text);
                      }
                    ),
                  ]
                )
            ]
          )
        )
    );
  }

}