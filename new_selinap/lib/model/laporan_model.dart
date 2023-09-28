import 'dart:convert';

import 'package:equatable/equatable.dart';

class LaporanModel extends Equatable {
	final String? id;
	final String? idPelajar;
	final String? idPelanggaran;
	final String? poinPelanggaran;
	final String? idGuru;
	final String? keterangan;
	final String? tanggalPelanggaran;
	final String? namaPelanggaran;
	final String? deskripsiPelanggaran;
	final String? idPengguna;
	final String? usernamePengguna;
	final String? passPengguna;
	final String? namaPengguna;
	final String? fotoPengguna;
	final String? levelPengguna;
	final String? telpPengguna;
	final String? surelPengguna;
	final String? terakhirMasuk;
	final String? nisPelajar;
	final String? namaPelajar;
	final String? passPelajar;
	final String? telpPelajar;
	final String? surelPelajar;
	final String? fotoPelajar;
	final String? statusPelajar;
	final String? poinPelajar;
	final String? levelPelajar;

	const LaporanModel({
		this.id, 
		this.idPelajar, 
		this.idPelanggaran, 
		this.poinPelanggaran, 
		this.idGuru, 
		this.keterangan, 
		this.tanggalPelanggaran, 
		this.namaPelanggaran, 
		this.deskripsiPelanggaran, 
		this.idPengguna, 
		this.usernamePengguna, 
		this.passPengguna, 
		this.namaPengguna, 
		this.fotoPengguna, 
		this.levelPengguna, 
		this.telpPengguna, 
		this.surelPengguna, 
		this.terakhirMasuk, 
		this.nisPelajar, 
		this.namaPelajar, 
		this.passPelajar, 
		this.telpPelajar, 
		this.surelPelajar, 
		this.fotoPelajar, 
		this.statusPelajar, 
		this.poinPelajar, 
		this.levelPelajar, 
	});

	factory LaporanModel.fromMap(Map<String, dynamic> data) => LaporanModel(
				id: data['id'] as String?,
				idPelajar: data['id_pelajar'] as String?,
				idPelanggaran: data['id_pelanggaran'] as String?,
				poinPelanggaran: data['poin_pelanggaran'] as String?,
				idGuru: data['id_guru'] as String?,
				keterangan: data['keterangan'] as String?,
				tanggalPelanggaran: data['tanggal_pelanggaran'] as String?,
				namaPelanggaran: data['nama_pelanggaran'] as String?,
				deskripsiPelanggaran: data['deskripsi_pelanggaran'] as String?,
				idPengguna: data['id_pengguna'] as String?,
				usernamePengguna: data['username_pengguna'] as String?,
				passPengguna: data['pass_pengguna'] as String?,
				namaPengguna: data['nama_pengguna'] as String?,
				fotoPengguna: data['foto_pengguna'] as String?,
				levelPengguna: data['level_pengguna'] as String?,
				telpPengguna: data['telp_pengguna'] as String?,
				surelPengguna: data['surel_pengguna'] as String?,
				terakhirMasuk: data['terakhir_masuk'] as String?,
				nisPelajar: data['nis_pelajar'] as String?,
				namaPelajar: data['nama_pelajar'] as String?,
				passPelajar: data['pass_pelajar'] as String?,
				telpPelajar: data['telp_pelajar'] as String?,
				surelPelajar: data['surel_pelajar'] as String?,
				fotoPelajar: data['foto_pelajar'] as String?,
				statusPelajar: data['status_pelajar'] as String?,
				poinPelajar: data['poin_pelajar'] as String?,
				levelPelajar: data['level_pelajar'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'id_pelajar': idPelajar,
				'id_pelanggaran': idPelanggaran,
				'poin_pelanggaran': poinPelanggaran,
				'id_guru': idGuru,
				'keterangan': keterangan,
				'tanggal_pelanggaran': tanggalPelanggaran,
				'nama_pelanggaran': namaPelanggaran,
				'deskripsi_pelanggaran': deskripsiPelanggaran,
				'id_pengguna': idPengguna,
				'username_pengguna': usernamePengguna,
				'pass_pengguna': passPengguna,
				'nama_pengguna': namaPengguna,
				'foto_pengguna': fotoPengguna,
				'level_pengguna': levelPengguna,
				'telp_pengguna': telpPengguna,
				'surel_pengguna': surelPengguna,
				'terakhir_masuk': terakhirMasuk,
				'nis_pelajar': nisPelajar,
				'nama_pelajar': namaPelajar,
				'pass_pelajar': passPelajar,
				'telp_pelajar': telpPelajar,
				'surel_pelajar': surelPelajar,
				'foto_pelajar': fotoPelajar,
				'status_pelajar': statusPelajar,
				'poin_pelajar': poinPelajar,
				'level_pelajar': levelPelajar,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LaporanModel].
	factory LaporanModel.fromJson(String data) {
		return LaporanModel.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [LaporanModel] to a JSON string.
	String toJson() => json.encode(toMap());

	LaporanModel copyWith({
		String? id,
		String? idPelajar,
		String? idPelanggaran,
		String? poinPelanggaran,
		String? idGuru,
		String? keterangan,
		String? tanggalPelanggaran,
		String? namaPelanggaran,
		String? deskripsiPelanggaran,
		String? idPengguna,
		String? usernamePengguna,
		String? passPengguna,
		String? namaPengguna,
		String? fotoPengguna,
		String? levelPengguna,
		String? telpPengguna,
		String? surelPengguna,
		String? terakhirMasuk,
		String? nisPelajar,
		String? namaPelajar,
		String? passPelajar,
		String? telpPelajar,
		String? surelPelajar,
		String? fotoPelajar,
		String? statusPelajar,
		String? poinPelajar,
		String? levelPelajar,
	}) {
		return LaporanModel(
			id: id ?? this.id,
			idPelajar: idPelajar ?? this.idPelajar,
			idPelanggaran: idPelanggaran ?? this.idPelanggaran,
			poinPelanggaran: poinPelanggaran ?? this.poinPelanggaran,
			idGuru: idGuru ?? this.idGuru,
			keterangan: keterangan ?? this.keterangan,
			tanggalPelanggaran: tanggalPelanggaran ?? this.tanggalPelanggaran,
			namaPelanggaran: namaPelanggaran ?? this.namaPelanggaran,
			deskripsiPelanggaran: deskripsiPelanggaran ?? this.deskripsiPelanggaran,
			idPengguna: idPengguna ?? this.idPengguna,
			usernamePengguna: usernamePengguna ?? this.usernamePengguna,
			passPengguna: passPengguna ?? this.passPengguna,
			namaPengguna: namaPengguna ?? this.namaPengguna,
			fotoPengguna: fotoPengguna ?? this.fotoPengguna,
			levelPengguna: levelPengguna ?? this.levelPengguna,
			telpPengguna: telpPengguna ?? this.telpPengguna,
			surelPengguna: surelPengguna ?? this.surelPengguna,
			terakhirMasuk: terakhirMasuk ?? this.terakhirMasuk,
			nisPelajar: nisPelajar ?? this.nisPelajar,
			namaPelajar: namaPelajar ?? this.namaPelajar,
			passPelajar: passPelajar ?? this.passPelajar,
			telpPelajar: telpPelajar ?? this.telpPelajar,
			surelPelajar: surelPelajar ?? this.surelPelajar,
			fotoPelajar: fotoPelajar ?? this.fotoPelajar,
			statusPelajar: statusPelajar ?? this.statusPelajar,
			poinPelajar: poinPelajar ?? this.poinPelajar,
			levelPelajar: levelPelajar ?? this.levelPelajar,
		);
	}

	@override
	List<Object?> get props {
		return [
				id,
				idPelajar,
				idPelanggaran,
				poinPelanggaran,
				idGuru,
				keterangan,
				tanggalPelanggaran,
				namaPelanggaran,
				deskripsiPelanggaran,
				idPengguna,
				usernamePengguna,
				passPengguna,
				namaPengguna,
				fotoPengguna,
				levelPengguna,
				telpPengguna,
				surelPengguna,
				terakhirMasuk,
				nisPelajar,
				namaPelajar,
				passPelajar,
				telpPelajar,
				surelPelajar,
				fotoPelajar,
				statusPelajar,
				poinPelajar,
				levelPelajar,
		];
	}
}
