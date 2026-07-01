class BookModel {
  BookModel({
    int? id,
    String? title,
    String? description,
    dynamic cover,
    dynamic fav,
    num? authorId,
    String? name,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _cover = cover;
    _fav = fav;
    _authorId = authorId;
    _name = name;
  }

  BookModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _cover = json['cover'];
    _fav = json['fav'];
    _authorId = json['author_id'];
    _name = json['name'];
  }

  int? _id;
  String? _title;
  String? _description;
  dynamic _cover;
  dynamic _fav;
  num? _authorId;
  String? _name;

  BookModel copyWith({
    int? id,
    String? title,
    String? description,
    dynamic cover,
    dynamic fav,
    num? authorId,
    String? name,
  }) => BookModel(
    id: id ?? _id,
    title: title ?? _title,
    description: description ?? _description,
    cover: cover ?? _cover,
    fav: fav ?? _fav,
    authorId: authorId ?? _authorId,
    name: name ?? _name,
  );

  int? get id => _id;

  String? get title => _title;

  String? get description => _description;

  dynamic get cover => _cover;

  dynamic get fav => _fav;

  num? get authorId => _authorId;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['cover'] = _cover;
    map['fav'] = _fav;
    map['author_id'] = _authorId;
    map['name'] = _name;
    return map;
  }
}
