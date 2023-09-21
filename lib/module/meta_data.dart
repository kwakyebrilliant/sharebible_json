class Metadata {
  String name;
  String shortname;
  String module;
  String year;
  // Add other metadata properties here

  Metadata({
    required this.name,
    required this.shortname,
    required this.module,
    required this.year,
    // Initialize other properties here
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      name: json['name'],
      shortname: json['shortname'],
      module: json['module'],
      year: json['year'],
      // Map other properties here
    );
  }
}

class Verse {
  String bookName;
  int book;
  int chapter;
  int verse;
  String text;

  Verse({
    required this.bookName,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      bookName: json['book_name'],
      book: json['book'],
      chapter: json['chapter'],
      verse: json['verse'],
      text: json['text'],
    );
  }
}
