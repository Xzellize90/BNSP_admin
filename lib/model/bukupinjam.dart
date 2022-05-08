class BukuPinjam {
  String? id_a;
  String? namaanggota;
  String? judulbuku;
  String? tglpinjam;
  String? tglkembali;
  

  BukuPinjam({
    this.id_a,
    this.namaanggota,
    this.judulbuku,
    this.tglpinjam,
    this.tglkembali
  });

  factory BukuPinjam.fromJson(Map<String, dynamic> json) => BukuPinjam(
        id_a: json['id_a'],
        namaanggota: json['namaanggota'],
        judulbuku: json['judulbuku'],
        tglpinjam: json['tglpinjam'],
        tglkembali:  json['tglkembali'],
        
      );

  Map<String, dynamic> toJson() => {
        'id_a': id_a,
        'namaanggota': namaanggota,
        'judulbuku': judulbuku,
        'tglpinjam': tglpinjam,
        'tglkembali': tglkembali
      };
}