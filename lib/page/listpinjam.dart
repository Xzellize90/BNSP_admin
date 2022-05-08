part of 'pages.dart';

class ListPinjam extends StatefulWidget {
  ListPinjam({Key? key}) : super(key: key);

  @override
  State<ListPinjam> createState() => _ListPinjamState();
}

class _ListPinjamState extends State<ListPinjam> {


  PageController pageController = PageController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  
  
    Future<List<BukuPinjam>> listPinjam() async {
    List<BukuPinjam> listBuku = [];
    var response = await http.get(Uri.parse(ApiBuku.URL_GET_BUKUPINJAM));
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List listJson = responseBody['data'];
        listJson.forEach((element) {
          listBuku.add(BukuPinjam.fromJson(element));
        });
      }
    } else {
      print('Request gagal');
    }
    return listBuku;
  }

  void deletePinjam(String id_a) async {
    var response =
        await http.post(Uri.parse(ApiBuku.URL_POST_KEMBALI), body: {
      'id_a': id_a
    });
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      var message = '';
      if (responseBody['success']) {
        message = 'Berhasil Dihapus';
      } else {
        message = 'Gagal Dihapus';
      }
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      print('Request gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Pengurus'),
      ),
    

      
      
      body: FutureBuilder(
        future: listPinjam(),
        builder: (context, AsyncSnapshot<List<BukuPinjam>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print('ConnectionState.done');
              if (snapshot.hasData) {
                if (snapshot.data!.length > 0) {
                  return buildList(snapshot.data!);
                } else {
                  return Center(child: Text('Tidak ada data'));
                }
              } else {
                print('snapshot error');
                return Center(child: Text('Error'));
              }
              break;
            default:
              print('Undefine Connection');
              return Center(child: Text('Undefine Connection'));
          }
        },
      ),
    );
  }
    Widget buildList(List<BukuPinjam> listbuku) {
    return ListView.builder(
      itemCount: listbuku.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var buku = listbuku[index];
        return Container(
          margin: EdgeInsets.fromLTRB(
            16,
            index == 0 ? 16 : 10,
            16,
            index == 9 ? 16 : 10,
          ),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: Colors.black26,
                ),
              ]),
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${buku.judulbuku}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Di Pinjam ${buku.tglpinjam} - ${buku.tglkembali}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[700],
                    child: InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text('Yakin untuk menghapus?'),
                                actions: [
                                  FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Tidak')),
                                  FlatButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'ok'),
                                      child: Text('Ya')),
                                ],
                              )).then((value) {
                        if (value == 'ok') {
                          deletePinjam(buku.namaanggota!);
                          listPinjam();
                          setState(() {});
                        }
                      }),
                      borderRadius: BorderRadius.circular(5),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.delete_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}