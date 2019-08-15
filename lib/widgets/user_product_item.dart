import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  String imageUrl;
  String title;

  UserProductItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {

                },
              ),
              IconButton(icon: Icon(Icons.delete),
              onPressed: () {

              },)
            ],
          ),
        ),
      ),
    );
  }
}
