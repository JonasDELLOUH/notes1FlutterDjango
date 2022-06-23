class Note {
  int id;
  String title;
  String text;
  String date_created;
  String date_updated;
  String isOnline;

  Note({required this.id, required this.title, required this.text, required this.date_created, required this.date_updated, required this.isOnline});

  Note copyWith({
    int? id,
    String? title,
    String? text,
    String? date_created,
    String? date_updated,
    String? inOnline
  }){
    return Note(id: id?? this.id, title: title?? this.title, text: text?? this.text, date_created: date_created??this.date_created, date_updated: date_updated?? this.date_updated, isOnline: 'false');
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'text': text,
      'date_created': date_created,
      'date_updated': date_updated,
      'isOnline': 'false'

    };
  }

  factory Note.fromMap(Map<String, dynamic> json) =>Note(id: json['id'], title: json['title'], text: json['text'], date_created: json['date_created'], date_updated: json['date_updated'], isOnline: json['isOnline']);
}
