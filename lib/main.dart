import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore _db = Firestore.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotiParty',
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.deepPurple,
        buttonTheme: ButtonThemeData(
          padding: const EdgeInsets.all(12.0),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.0)),
          ),
        ),
        textTheme: const TextTheme(
          display4: const TextStyle(
              debugLabel: 'whiteMountainView display4',
              fontFamily: 'Roboto',
              inherit: true,
              color: Colors.white70,
              decoration: TextDecoration.none),
          display3: const TextStyle(
            debugLabel: 'whiteMountainView display3',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white70,
            decoration: TextDecoration.none,
          ),
          display2: const TextStyle(
            debugLabel: 'whiteMountainView display2',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white70,
            decoration: TextDecoration.none,
          ),
          display1: const TextStyle(
            debugLabel: 'whiteMountainView display1',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white70,
            decoration: TextDecoration.none,
          ),
          headline: const TextStyle(
            debugLabel: 'whiteMountainView headline',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          title: const TextStyle(
            debugLabel: 'whiteMountainView title',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          subhead: const TextStyle(
            debugLabel: 'whiteMountainView subhead',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          body2: const TextStyle(
            debugLabel: 'whiteMountainView body2',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          body1: const TextStyle(
            debugLabel: 'whiteMountainView body1',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          caption: const TextStyle(
            debugLabel: 'whiteMountainView caption',
            fontFamily: 'Roboto',
            inherit: true,
            color: Colors.white70,
            decoration: TextDecoration.none,
          ),
          button: const TextStyle(
            debugLabel: 'whiteMountainView button',
            fontFamily: 'Roboto',
            fontSize: 16.0,
            // inherit: true,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      home: MyHomePage(
        title: 'SpotiParty',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _searchController = TextEditingController();
  List<int> _votes = List<int>();
  CollectionReference get musics => _db.collection('musics');

  Future<Null> _addMusic(String name) async {
    final DocumentReference document = musics.document();
    document.setData(<String, dynamic>{
      'name': name,
      'votes': 0,
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Your music',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            RaisedButton(
              child: Center(child: Text('Add Music')),
              onPressed: () {
                if (_searchController.text != '')
                  _addMusic(_searchController.text);
                _searchController.clear();
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder(
                stream: Firestore.instance.collection('musics').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data.documents[index];

                        while (_votes.length < snapshot.data.documents.length) {
                          _votes.add(0);
                        }

                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                title: Text(" ${ds['name']}"),
                                subtitle: Text(" ${ds['votes']}"),
                              ),
                            ),
                            FlatButton(
                              shape: BeveledRectangleBorder(),
                              child: Icon(
                                Icons.thumb_up,
                                color: _votes[index] == 1
                                    ? Colors.green
                                    : Colors.white,
                              ),
                              onPressed: () async {
                                if (_votes[index] != 1) {
                                  setState(() {
                                    _votes[index] = 1;
                                  });

                                  await Firestore.instance
                                      .runTransaction((transaction) async {
                                    DocumentSnapshot meeting =
                                        await transaction.get(ds.reference);
                                    await transaction.update(meeting.reference,
                                        {'votes': ds['votes'] + 1});
                                  });
                                } else {
                                  setState(() {
                                    _votes[index] = 0;
                                  });

                                  await Firestore.instance
                                      .runTransaction((transaction) async {
                                    DocumentSnapshot meeting =
                                        await transaction.get(ds.reference);
                                    await transaction.update(meeting.reference,
                                        {'votes': ds['votes'] - 1});
                                  });
                                }
                              },
                            ),
                            FlatButton(
                              shape: BeveledRectangleBorder(),
                              child: Icon(
                                Icons.thumb_down,
                                color: _votes[index] == -1
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () async {
                                if (_votes[index] != -1) {
                                  setState(() {
                                    _votes[index] = -1;
                                  });

                                  await Firestore.instance
                                      .runTransaction((transaction) async {
                                    DocumentSnapshot meeting =
                                        await transaction.get(ds.reference);
                                    await transaction.update(meeting.reference,
                                        {'votes': ds['votes'] - 1});
                                  });
                                } else {
                                  setState(() {
                                    _votes[index] = 0;
                                  });

                                  await Firestore.instance
                                      .runTransaction((transaction) async {
                                    DocumentSnapshot meeting =
                                        await transaction.get(ds.reference);
                                    await transaction.update(meeting.reference,
                                        {'votes': ds['votes'] + 1});
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
