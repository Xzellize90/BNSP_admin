part of 'pages.dart';

class Anggota extends StatefulWidget {
  Anggota({Key? key}) : super(key: key);

  @override
  State<Anggota> createState() => _AnggotaState();
}

class _AnggotaState extends State<Anggota> {



  PageController pageController = PageController();
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengurus'),
      ),

      body: Container(
        color: Colors.green,
      ),
    );
  }
}