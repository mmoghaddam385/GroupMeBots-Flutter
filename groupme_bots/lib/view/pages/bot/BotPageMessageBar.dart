import 'package:flutter/material.dart';
import 'package:groupme_bots/view/Dimens.dart' as dimens;

class BotPageMessageBar extends StatelessWidget {

  final TextEditingController messageController;
  final VoidCallback onMessageSend;

  BotPageMessageBar({this.messageController, this.onMessageSend}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 2)],
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16)
        )
      ),
      child: 
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: dimens.GAP_DEFAULT, 
          horizontal: dimens.GAP_LARGE
        ),
        child:
          Row(
            children: <Widget> [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: dimens.GAP_DEFAULT),
                  child: TextField(
                    autofocus: false,
                    controller: messageController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null, // Lets the view grow vertically as the user types
                    decoration: new InputDecoration(
                      hintText: "What would Geoffrey say?",
                      hintStyle: TextStyle(color: Colors.white54),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: null
                    ),
                    cursorColor: Colors.white70,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.white,
                textColor: Theme.of(context).accentColor,
                child: Text("Send"),
                onPressed: onMessageSend
              ),
            ]
          )
      )
    );
  }

}