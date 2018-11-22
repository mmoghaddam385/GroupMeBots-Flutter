

abstract class DatabaseEntity<T> {

  /// Get the table name that this entity lives in
  String getTableName();

  /// Return a valid SQL create table query to create this table
  String getTableCreateStatement();

  /// Return a map of values representing this entity to insert into the db
  Map<String, dynamic> toMap(T value);

  /// Return a new instance of this entity from a map
  T fromMap(Map<String, dynamic> map);

  /// Callback for when this entity is inserted into the database
  void onInsert(T value, int id);
}