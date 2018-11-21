
import 'package:flutter/material.dart';
import 'package:groupme_bots/model/BotMessage.dart';
import 'package:groupme_bots/view/Dimens.dart' as Dimens;

class BotMessageView extends StatefulWidget {
  
  BotMessage _initialMessage;

  BotMessageView(this._initialMessage);

  @override
  State<StatefulWidget> createState() => _BotMessageViewState();
 
}

class _BotMessageViewState extends State<BotMessageView> {
  
  BotMessage _message;

  @override
  void initState() {
    super.initState();
    _message = widget._initialMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.GAP_DEFAULT,
          right: Dimens.GAP_DEFAULT,
          bottom: Dimens.GAP_DEFAULT,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Dimens.GAP_LARGE,
            horizontal: Dimens.GAP_LARGE
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24)
            ),
          ),
          child: 
            Text(
              _message.text, 
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              )
            ),
        ),
      )
    );
  }


} 