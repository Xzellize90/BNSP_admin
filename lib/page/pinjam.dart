part of 'pages.dart';

class Pinjam extends StatefulWidget {

  @override
  State<Pinjam> createState() => _PinjamState();
}

class _PinjamState extends State<Pinjam> {
 


  PageController pageController = PageController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengurus'),
      ),
      

      body: Container(
        color: Colors.orange,
      ),
    );
  }
}