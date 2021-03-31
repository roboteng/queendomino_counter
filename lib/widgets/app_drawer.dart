import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queendomino_counter/providers/mode_provider.dart';
import 'package:queendomino_counter/screens/dynamic_table.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Text(
              'Menu',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('New Game'),
          ),
          ListTile(
            leading: Icon(Icons.group_add),
            title: Text('Change Players'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => DynamicTable())),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text(
              'History',
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Math Mode'),
            subtitle: Text(
              'Multiply things yourself',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            trailing: Switch(
              onChanged: (value) {
                Provider.of<ModeProvider>(context, listen: false).math =
                    value ? MathMode.math : MathMode.easy;
              },
              value: Provider.of<ModeProvider>(context).math == MathMode.math,
            ),
          ),
          ListTile(
            leading: Icon(Icons.developer_board),
            title: Text('Kingdomino Mode'),
            subtitle: Text(
              'Remove the extra fields',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            trailing: Switch(
              onChanged: (value) {
                Provider.of<ModeProvider>(context, listen: false).game =
                    value ? GameMode.kingdomino : GameMode.queendomino;
              },
              value: Provider.of<ModeProvider>(context).game ==
                  GameMode.kingdomino,
            ),
          ),
        ],
      ),
    );
  }
}
