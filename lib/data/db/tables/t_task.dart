import 'package:drift/drift.dart';

class TTask extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get note => text().nullable()();
  IntColumn get pomodoroCount => integer().withDefault(const Constant(1))();
  DateTimeColumn get startTime => dateTime().nullable()();
  DateTimeColumn get dueTime => dateTime().nullable()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
