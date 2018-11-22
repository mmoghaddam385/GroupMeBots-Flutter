
import 'package:groupme_bots/db/DatabaseEntity.dart';
import 'package:meta/meta.dart';

const _TABLE_NAME = "bot_messages";
const _MESSAGE_ID_COLUMN = "message_id";
const _BOT_ID_COLUMN = "bot_id";
const _MESSAGE_TEXT_COLUMN = "message_text";
const _TIME_STAMP_COLUMN = "time_stamp";
const _STATE_COLUMN = "message_state";

class BotMessage {

  int messageId;
  final int botId;
  final String text;
  final DateTime timeStamp;
  BotMessageState state;

  BotMessage({@required this.messageId, 
              @required this.botId,
              @required this.text,
              @required this.state,
              @required this.timeStamp});

  
  
}

class BotMessageEntity implements DatabaseEntity<BotMessage> {
  
  @override
  String getTableName() => _TABLE_NAME;

  @override
  String getTableCreateStatement() => """CREATE TABLE $_TABLE_NAME (
    $_MESSAGE_ID_COLUMN integer PRIMARY KEY AUTOINCREMENT,
    $_BOT_ID_COLUMN integer NOT NULL,
    $_MESSAGE_TEXT_COLUMN text NOT NULL,
    $_STATE_COLUMN integer NOT NULL,
    $_TIME_STAMP_COLUMN integer NOT NULL)""";
  
  @override
  Map<String, dynamic> toMap(BotMessage message) => {
    _BOT_ID_COLUMN: message.botId,
    _MESSAGE_TEXT_COLUMN: message.text,
    _STATE_COLUMN: message.state.index,
    _TIME_STAMP_COLUMN: message.timeStamp.millisecondsSinceEpoch
  };

  @override
  BotMessage fromMap(Map<String, dynamic> map) {
    return BotMessage(
      messageId: map[_MESSAGE_ID_COLUMN],
      botId: map[_BOT_ID_COLUMN],
      text: map[_MESSAGE_TEXT_COLUMN],
      state: BotMessageState.values[map[_STATE_COLUMN]],
      timeStamp: DateTime.fromMicrosecondsSinceEpoch(map[_TIME_STAMP_COLUMN])
    );
  }

  @override
  void onInsert(BotMessage value, int id) {
    value.messageId = id;
  }
}

enum BotMessageState {
  PENDING, SENT, FAILED
}