class Todoapi {
  int id;
  String title;
  bool completed;

  Todoapi(int id, String title, bool completed) {
    this.id = id;
    this.title = title;
    this.completed = completed;
  }

  Todoapi.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        completed = json['completed'];

  Map toJson() {
    return {'id': id, 'title': title, 'completed': completed};
  }
}
