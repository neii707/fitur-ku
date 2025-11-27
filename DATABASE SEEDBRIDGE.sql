CREATE TYPE enum_transaksi AS ENUM('Dikemas', 'Dikirim', 'Diterima', 'Menunggu Konfirmasi', 'Selesai');
CREATE TYPE enum_pembayaran AS ENUM ('Tunai', 'Non Tunai');
CREATE TYPE enum_keranjang AS ENUM('Dipesan', 'Belum Dipesan');

CREATE TABLE role(
id_role SERIAL PRIMARY KEY,
nama_role VARCHAR NOT NULL
);

CREATE table kategori_benih(
id_kategori_benih serial primary key,
nama_kategori Varchar(64) not null
);

CREATE TABLE keranjang_pesanan(
id_keranjang SERIAL PRIMARY KEY,
status_keranjang enum_keranjang NOT NULL
);

CREATE TABLE users(
id_user SERIAL PRIMARY KEY,
username VARCHAR(32) UNIQUE NOT NULL,
password VARCHAR(32) UNIQUE NOT NULL,
nama VARCHAR(20) NOT NULL,
no_telp VARCHAR(15) NOT NULL,

id_keranjang INTEGER REFERENCES keranjang_pesanan(id_keranjang),
id_role INTEGER REFERENCES role(id_role)
);

CREATE TABLE benih(
id_benih SERIAL PRIMARY KEY,
nama_benih VARCHAR(32) NOT NULL,
tanggal_masuk DATE NOT NULL,
kadaluarsa DATE NOT NULL,
harga INTEGER NOT NULL,

id_user INTEGER REFERENCES users(id_user),
id_kategori_benih INTEGER REFERENCES kategori_benih(id_kategori_benih)
);

CREATE TABLE pesanan(
id_pesanan SERIAL PRIMARY KEY,
tanggal_pesanan DATE NOT NULL,

id_user INTEGER REFERENCES users(id_user)
);

CREATE TABLE detail_keranjang(
id_detail_keranjang SERIAL PRIMARY KEY,
quantity INTEGER NOT NULL,

id_benih INTEGER REFERENCES benih(id_benih),
id_keranjang INTEGER REFERENCES keranjang_pesanan(id_keranjang)
);

CREATE TABLE alamat(
id_alamat SERIAL PRIMARY KEY,

id_user INTEGER REFERENCES users(id_user)
);

CREATE TABLE alamat_pesanan(
id_alamat_pesanan SERIAL PRIMARY KEY,

id_pesanan INTEGER REFERENCES pesanan(id_pesanan)
);

CREATE TABLE detail_pesanan(
id_detail_pesanan SERIAL PRIMARY KEY,
quantity INTEGER NOT NULL,

id_pesanan INTEGER REFERENCES pesanan(id_pesanan),
id_benih INTEGER REFERENCES benih(id_benih)
);

CREATE TABLE transaksi(
id_transaksi SERIAL PRIMARY KEY,
tanggal_transaksi DATE NOT NULL,
metode_pembayaran enum_pembayaran NOT NULL,
status_transaksi enum_transaksi NOT NULL,

id_pesanan INTEGER REFERENCES pesanan(id_pesanan)
);

CREATE TABLE riwayat_produksi(
id_produksi SERIAL PRIMARY KEY,
tanggal_produksi DATE NOT NULL,
jumlah_produksi INTEGER NOT NULL,

id_benih INTEGER REFERENCES benih(id_benih)
);

CREATE TABLE desa(
id_desa SERIAL PRIMARY KEY,
nama_desa  VARCHAR(32) NOT NULL,

id_alamat_pesanan INTEGER REFERENCES alamat_pesanan(id_alamat_pesanan),
id_alamat INTEGER REFERENCES alamat(id_alamat)
);

CREATE TABLE kecamatan(
id_kecamatan SERIAL PRIMARY KEY,
nama_kecamatan  VARCHAR(32) NOT NULL,

id_alamat_pesanan INTEGER REFERENCES alamat_pesanan(id_alamat_pesanan),
id_alamat INTEGER REFERENCES alamat(id_alamat)
);

CREATE TABLE kabupaten(
id_kabupaten SERIAL PRIMARY KEY,
nama_kabupaten  VARCHAR(32) NOT NULL,

id_alamat_pesanan INTEGER REFERENCES alamat_pesanan(id_alamat_pesanan),
id_alamat INTEGER REFERENCES alamat(id_alamat)
);

INSERT INTO role (nama_role) VALUES
('Petani'),
('Produsen'),
('Admin');

INSERT INTO keranjang_pesanan (id_keranjang, status_keranjang) VALUES
(1, 'Belum Dipesan'),
(2, 'Dipesan'),
(3, 'Belum Dipesan'),
(4, 'Dipesan'),
(5, 'Belum Dipesan'),
(6, 'Belum Dipesan'),
(7, 'Dipesan'),
(8, 'Belum Dipesan'),
(9, 'Dipesan'),
(10, 'Belum Dipesan'),
(11, 'Dipesan'),
(12, 'Belum Dipesan'),
(13, 'Dipesan'),
(14, 'Belum Dipesan'),
(15, 'Dipesan');

INSERT INTO users (username, password, nama, no_telp, id_keranjang, id_role) VALUES
('petani_andi', 'andi123', 'Andi Santoso', '081234567890', 1, 1),
('produsen_budi', 'budi123', 'Budi Prasetyo', '082345678901', 2, 2),
('admin_sri', 'sri123', 'Sri Lestari', '083456789012', 3, 3),
('petani_joko', 'joko123', 'Joko Susanto', '082376244616', 4, 1),
('produsen_eko', 'eko123', 'Eko Saputra', '082134567812', 5, 2),
('admin_mawar', 'mawar123', 'Mawar Fitriani', '083145678912', 6, 3),
('petani_adi', 'adi123', 'Adi Triyono', '082245678123', 7, 1),
('produsen_sinta', 'sinta123', 'Sinta Kumalasari', '085334567891', 8, 2),
('admin_agus', 'agus123', 'Agus Hartono', '089612345678', 9, 3),
('petani_rani', 'rani123', 'Rani Ayu Dewi', '087834562311', 10, 1),
('produsen_lilis', 'lilis123', 'Lilis Pratiwi', '082134891234', 11, 2),
('admin_bagus', 'bagus123', 'Bagus Wibisono', '081355662211', 12, 3),
('petani_nanda', 'nanda123', 'Nanda Rahmawati', '081244718236', 13, 1),
('produsen_seno', 'seno123', 'Seno Dwi Kurniawan', '089611238737', 14, 2),
('admin_dwi', 'dwi123', 'Dwi Sulistyo', '083142312457', 15, 3);


INSERT INTO alamat (id_user) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15);

INSERT INTO kategori_benih(id_kategori_benih, nama_kategori) VALUES
(1, 'Padi'),
(2, 'Jagung'),
(3, 'Cabai'),
(4, 'Sayuran');

INSERT INTO benih (nama_benih, tanggal_masuk, kadaluarsa, harga, id_kategori_benih, id_user) 
VALUES
-- kategori 1 (padi)
('Padi IR64', '2025-01-10', '2026-01-10', 50000, 1, 2),
('Padi Inpari 30', '2025-02-12', '2026-02-12', 55000, 1, 5),
('Padi Mekongga', '2025-03-05', '2026-03-05', 60000, 1, 8),

-- kategori 2 (jagung)
('Jagung Bisi-2', '2025-01-12', '2026-01-12', 45000, 2, 2),
('Jagung Pioneer P32', '2025-04-22', '2026-04-22', 70000, 2, 11),
('Jagung NK212', '2025-07-11', '2026-07-11', 65000, 2, 14),

-- kategori 3 (cabai)
('Cabai Rawit Lokal', '2025-01-15', '2026-01-15', 30000, 3, 5),
('Cabai Besar TM 99', '2025-09-09', '2026-09-09', 35000, 3, 2),
('Cabai Lado F1', '2025-06-18', '2026-06-18', 38000, 3, 8),
('Cabai Arimbi', '2025-02-20', '2026-02-20', 36000, 3, 11),

-- kategori 4 (sayuran)
('Selada Hijau', '2025-03-10', '2026-03-10', 20000, 4, 14),
('Bayam Merah', '2025-03-15', '2026-03-15', 18000, 4, 2),
('Kangkung Darat', '2025-04-01', '2026-04-01', 15000, 4, 5),
('Sawi Putih', '2025-04-18', '2026-04-18', 22000, 4, 8),
('Tomat Lokal', '2025-05-02', '2026-05-02', 25000, 4, 11);


INSERT INTO pesanan (tanggal_pesanan, id_user)
VALUES
('2025-02-01', 1),
('2025-02-03', 2),
('2025-02-05', 3),
('2025-03-29', 4),
('2025-04-16', 5),
('2025-05-05', 6),
('2025-06-22', 7),
('2025-07-13', 8),
('2025-08-02', 9),
('2025-09-20', 10),
('2025-01-14', 11),
('2025-01-18', 12),
('2025-02-02', 13),
('2025-02-11', 14),
('2025-02-19', 15);

INSERT INTO detail_pesanan (quantity, id_pesanan, id_benih)
VALUES
(10, 1, 1),
(14, 1, 2),
(25, 2, 3),
(20, 4, 2),
(20, 5, 7),
(15, 6, 4),
(26, 7, 8),
(30, 8, 6),
(18, 9, 10),
(13, 10, 9),
(10,11,11),
(15,12,12),
(15,13,13),
(18,14,14),
(12,15,15);

INSERT INTO riwayat_produksi (tanggal_produksi, jumlah_produksi, id_benih)
VALUES
('2025-01-20', 500, 1),
('2025-01-25', 300, 2),
('2025-01-30', 200, 3),
('2025-04-09', 600, 2),
('2025-05-23', 700, 5),
('2025-06-18', 550, 7),
('2025-07-30', 420, 8),
('2025-08-14', 900, 6),
('2025-09-22', 680, 9),
('2025-10-11', 750, 10),
('2025-01-19',350,11),
('2025-02-02',420,12),
('2025-02-12',510,13),
('2025-02-25',610,14),
('2025-03-04',470,15);

INSERT INTO transaksi (tanggal_transaksi, status_transaksi, metode_pembayaran, id_pesanan)
VALUES
('2025-02-02', 'Selesai', 'Non Tunai', 1),
('2025-02-04', 'Diterima', 'Tunai', 2),
('2025-02-06', 'Dikemas', 'Non Tunai', 3),
('2025-03-30', 'Dikirim', 'Non Tunai', 4),
('2025-04-17', 'Dikemas', 'Non Tunai', 5),
('2025-05-07', 'Selesai', 'Tunai', 6),
('2025-06-23', 'Selesai', 'Tunai', 7),
('2025-07-14', 'Dikirim', 'Non Tunai', 8),
('2025-08-03', 'Diterima', 'Non Tunai', 9),
('2025-09-21', 'Selesai', 'Tunai', 10),
('2025-01-14', 'Selesai', 'Non Tunai', 11),
('2025-01-20', 'Dikemas', 'Non Tunai', 12),
('2025-02-03', 'Diterima', 'Tunai', 13),
('2025-02-15', 'Selesai', 'Non Tunai', 14),
('2025-02-20', 'Dikemas', 'Tunai', 15);

INSERT INTO detail_pesanan (quantity, id_pesanan, id_benih)
VALUES
(5, 1, 1),
(10, 1, 2),
(25, 2, 3),
(17, 4, 2),
(20, 5, 7),
(12, 6, 4),
(26, 7, 8),
(30, 8, 6),
(18, 9, 10),
(13, 10, 9),
(9,11,11),
(12,12,12),
(15,13,13),
(18,14,14),
(9,15,15);

INSERT INTO alamat_pesanan (id_pesanan)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15);

INSERT INTO desa(id_alamat, nama_desa, id_alamat_pesanan) VALUES
(1,  'Desa Sumberagung', 1),
(2,  'Desa Karangrejo', 2),
(3,  'Desa Jetis', 3),
(4,  'Desa Ngablak', 4),
(5,  'Desa Banyuurip', 5),
(6,  'Desa Kebonsari', 6),
(7,  'Desa Mulyoagung', 7),
(8,  'Desa Pucangombo', 8),
(9,  'Desa Kendalrejo', 9),
(10, 'Desa Sambirejo', 10),
(11, 'Desa Nglawak', 11),
(12, 'Desa Batokan', 12),
(13, 'Desa Sarirejo', 13),
(14, 'Desa Mlaten', 14),
(15, 'Desa Mojowarno', 15);

INSERT INTO kecamatan (id_alamat, nama_kecamatan, id_alamat_pesanan) VALUES
(1,  'Kecamatan Ngancar', 1),
(2,  'Kecamatan Wates', 2),
(3,  'Kecamatan Kalidawir', 3),
(4,  'Kecamatan Kedungwaru', 4),
(5,  'Kecamatan Boyolangu', 5),
(6,  'Kecamatan Kandat', 6),
(7,  'Kecamatan Tulungagung', 7),
(8,  'Kecamatan Tanggunggunung', 8),
(9,  'Kecamatan Ngunut', 9),
(10, 'Kecamatan Pagerwojo', 10),
(11, 'Kecamatan Kertosono', 11),
(12, 'Kecamatan Kasreman', 12),
(13, 'Kecamatan Karangjati', 13),
(14, 'Kecamatan Pucuk', 14),
(15, 'Kecamatan Mojoagung', 15);

INSERT INTO kabupaten (id_alamat, nama_kabupaten, id_alamat_pesanan) VALUES
(1,  'Jember', 1),
(2,  'Jember', 2),
(3,  'Jember', 3),
(4,  'Jember', 4),
(5,  'Jember', 5),
(6,  'Jember', 6),
(7,  'Jember', 7),
(8,  'Jember', 8),
(9,  'Jember', 9),
(10, 'Jember', 10),
(11, 'Jember', 11),
(12, 'Jember', 12),
(13, 'Jember', 13),
(14, 'Jember', 14),
(15, 'Jember', 15);