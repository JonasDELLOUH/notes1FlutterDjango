class Note {
  int id;
  String title;
  String text;
  String date_created;
  String date_updated;

  Note({required this.id, required this.title, required this.text, required this.date_created, required this.date_updated});

  Note copyWith({
    int? id,
    String? title,
    String? text,
    String? date_created,
    String? date_updated
  }){
    return Note(id: id?? this.id, title: title?? this.title, text: text?? this.text, date_created: date_created??this.date_created, date_updated: date_updated?? this.date_updated);
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'text': text,
      'date_created': date_created,
      'date_updated': date_updated
    };
  }

  factory Note.fromMap(Map<String, dynamic> json) =>Note(id: json['id'], title: json['title'], text: json['text'], date_created: json['date_created'], date_updated: json['date_updated']);
}
