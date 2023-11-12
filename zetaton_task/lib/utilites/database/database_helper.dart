import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pa;
import 'package:zetaton_task/screens/home/models/pictures_model.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  // Get Initiate database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initiate database method
  Future<Database> _initDatabase() async {
    String path = pa.join(await getDatabasesPath(), 'photo_database.db');
    return await openDatabase(path,
        version: 7, onCreate: _createDb, onUpgrade: _upgradeDb);
  }

  // upgrade database to the newest version on users device
  Future<void> _upgradeDb(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 7) {
      // Add new columns or modify the schema as needed
      await db.execute('ALTER TABLE photos ADD COLUMN authToken TEXT');
    }
    // Add more upgrade logic for other versions if needed
  }

  // Create database columns
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE photos(
      id INTEGER PRIMARY KEY,
      width INTEGER,
      height INTEGER,
      url TEXT,
      photographer TEXT,
      photographer_url TEXT,
      photographer_id INTEGER,
      avg_color TEXT,
      original TEXT,
      large2X TEXT,
      large TEXT,
      medium TEXT,
      small TEXT,
      portrait TEXT,
      landscape TEXT,
      tiny TEXT,
      liked INTEGER,
      alt TEXT,
      downloading INTEGER,
      src TEXT, 
      authToken TEXT
    )
  ''');
  }

  // insert new item to database
  Future<int> _insertNewItem(Database db, Photo photo,
      Map<String, dynamic> srcMap, String authToken) async {
    int insert = 0;
    try {
      insert = await db.insert('photos', {
        'id': photo.id,
        'width': photo.width,
        'height': photo.height,
        'url': photo.url,
        'photographer': photo.photographer,
        'photographer_url': photo.photographerUrl,
        'photographer_id': photo.photographerId,
        'avg_color': photo.avgColor,
        'original': srcMap['original'],
        'large2X': srcMap['large2X'],
        'large': srcMap['large'],
        'medium': srcMap['medium'],
        'small': srcMap['small'],
        'portrait': srcMap['portrait'],
        'landscape': srcMap['landscape'],
        'tiny': srcMap['tiny'],
        'liked': photo.liked ? 1 : 0,
        'alt': photo.alt,
        'authToken': authToken,
      });
    } catch (e) {
      print(e);
    }
    return insert;
  }

  // update item already exist on database
  Future<int> _updateItemOnDataBase(Database db, Photo photo,
      Map<String, dynamic> srcMap, String authToken) async {
    int update = 0;
    try {
      update = await db.update(
        'photos',
        {
          'width': photo.width,
          'height': photo.height,
          'url': photo.url,
          'photographer': photo.photographer,
          'photographer_url': photo.photographerUrl,
          'photographer_id': photo.photographerId,
          'avg_color': photo.avgColor,
          'original': srcMap['original'],
          'large2X': srcMap['large2X'],
          'large': srcMap['large'],
          'medium': srcMap['medium'],
          'small': srcMap['small'],
          'portrait': srcMap['portrait'],
          'landscape': srcMap['landscape'],
          'tiny': srcMap['tiny'],
          'liked': photo.liked ? 1 : 0,
          'alt': photo.alt,
        },
        where: 'id = ? AND authToken = ?',
        whereArgs: [photo.id, authToken],
      );
    } catch (e) {
      print(e);
    }
    return update;
  }

  // insert or update new photo on database
  Future<int> insertPhoto(Photo photo, String authToken) async {
    Database db = await instance.database;

    // Extract src map from the photo
    Map<String, dynamic> srcMap = photo.src.toMap();

    // Check if a record with the same id and authToken already exists
    List<Map<String, dynamic>> existingRecords = await db.query(
      'photos',
      where: 'id = ? AND authToken = ?',
      whereArgs: [photo.id, authToken],
    );

    if (existingRecords.isNotEmpty) {
      // Update the existing record
      return _updateItemOnDataBase(db, photo, srcMap, authToken);
    } else {
      // Insert the new record with authToken
      return _insertNewItem(db, photo, srcMap, authToken);
    }
  }

  // Get all users favorites photos from local database
  Future<List<Photo>> getPhotosForUser(String authToken) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(
      'photos',
      where: 'authToken = ?',
      whereArgs: [authToken],
    );
    return List.generate(maps.length, (i) {
      return Photo.fromMap(maps[i]);
    });
  }

  // Delete users selected photo from favorites
  Future<int> deletePhotoForUser(int photoId, String authToken) async {
    Database db = await instance.database;
    return await db.delete(
      'photos',
      where: 'id = ? AND authToken = ?',
      whereArgs: [photoId, authToken],
    );
  }
}
