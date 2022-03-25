import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:news_feed/models/db/dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


part 'database.g.dart';

class ArticleRecords extends Table {
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishDate => text()();
  TextColumn get content => text()();

  @override
  Set<Column> get primaryKey => {url};
}

 @DriftDatabase(tables: [ArticleRecords], daos: [NewsDao])
 class MyDatabase extends _$MyDatabase {
   // we tell the database where to store the data with this constructor
   MyDatabase() : super(_openConnection());

   // you should bump this number whenever you change or add a table definition.
   // Migrations are covered later in the documentation.
   @override
   int get schemaVersion => 1;
 }

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'news.db'));
    return NativeDatabase(file);
  });
}