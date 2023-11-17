import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:k_focus/data/db/tables/t_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'kfocus_db.g.dart';

@DriftDatabase(tables: [TTask])
class KFocusDB extends _$KFocusDB {
  KFocusDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'kfocus.db'));
    return NativeDatabase.createInBackground(file);
  });
}
