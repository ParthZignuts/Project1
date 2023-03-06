import '../screenbarrel/screen_barrel.dart';
class DrawerListTile extends StatelessWidget {
  final Function onDrawerTap;
  final Icon icon;
  final String drawerTitle;

  DrawerListTile({
    required this.onDrawerTap,
    required this.icon,
    required this.drawerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text("${drawerTitle}"),
      onTap: onDrawerTap(),
    );
  }
}