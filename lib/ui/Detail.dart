import 'package:flutter/material.dart';
import './editData.dart';
import 'package:http/http.dart' as http;
import 'package:ags_wis/in/input.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData(id) {
    //sambung ke hp
    var url = "http://192.168.43.6/apiflutter/penjualan/delete";
    //sambung ke virtual
    // var url = "http://10.0.2.2/apiflutter/penjualan/delete";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm(id) {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to delete '${widget.list[widget.index]['nama']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("OK Delete!"),
          color: Colors.red[400],
          onPressed: () {
            deletePenjualan(id);
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Input(),
            ));
          },
        ),
        new RaisedButton(
          child: new Text("Cancel!"),
          color: Colors.lightBlueAccent,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['nama']}"),
      ),
      body: new Container(
          height: 400.0,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
                child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index]['nama'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Keterangan : ${widget.list[widget.index]['keterangan']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Harga : ${widget.list[widget.index]['harga']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Stok : ${widget.list[widget.index]['stok']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.lightBlueAccent,
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new EditData(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.red[400],
                      onPressed: () => confirm(widget.list[widget.index]['id']),
                    ),
                  ],
                )
              ],
            )),
          )),
    );
  }

  Future<http.Response> deletePenjualan(id) async {
    final http.Response response = await http
        .delete("http://10.0.2.2/apiflutter/penjualan/save_update/$id");

    return response;
  }
}
