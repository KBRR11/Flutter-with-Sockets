class Band {
  String id;
  String name;
  int votes;

//constructor
  Band({this.id, this.name, this.votes});

//Factory constructor= recibe cierto tipo de argumentos y regresa una
//nueva instancia de mi clase

  factory Band.fromMap(Map<String, dynamic> obj) => Band(
      id: obj.containsKey('id') ? obj['id'] : 'no-id',
      name: obj.containsKey('name') ? obj['name'] : 'no-name',
      votes: obj.containsKey('votes') ? obj['votes'] : 'no-votes');
}
