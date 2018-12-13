
import 'package:shared_preferences/shared_preferences.dart';

final GroupMeMessageCache groupMeMessageCache = GroupMeMessageCache._privateCtor();

class GroupMeMessageCache {

  static final String _BOT_ID_PREFS_KEY = "botId";

  GroupMeMessageCache._privateCtor();

  String _botId;
  String get botId => _botId;
  set botId(String id) {
    _botId = id;
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setString(_BOT_ID_PREFS_KEY, id)
    ).catchError(
      (error) => print("Error saving bot ID to prefs: $error")
    );
  }

  // Get the initial bot ID from shared prefs 
  void initBotId() {
    SharedPreferences.getInstance().then(
      (prefs) => _botId = prefs.getString(_BOT_ID_PREFS_KEY)
    ).catchError(
      (error) => print("Error retrieving bot id from prefs: $error")
    );
  }

}