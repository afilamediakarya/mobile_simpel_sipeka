class TambahDataSuaraSementaraModel {
  final String nik;
  final String noKK;
  final String name;
  final String jenisKelamin;
  final String statusPerkawinan;
  final String tempatLahir;
  final String tanggalLahir;
  final String address;
  final String idKelurahan;
  final String kelurahan;
  final String rt;
  final String rw;
  final String tps;

  TambahDataSuaraSementaraModel({
    required this.nik,
    required this.noKK,
    required this.name,
    required this.jenisKelamin,
    required this.statusPerkawinan,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.address,
    required this.idKelurahan,
    required this.kelurahan,
    required this.rt,
    required this.rw,
    required this.tps,
  });

  Map<String, dynamic> toMap() {
    return {
      'nik': nik,
      'noKK': noKK,
      'name': name,
      'jenisKelamin': jenisKelamin,
      'statusPerkawinan': statusPerkawinan,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'address': address,
      'idKelurahan': idKelurahan,
      'kelurahan': kelurahan,
      'rt': rt,
      'rw': rw,
      'tps': tps,
    };
  }
}
