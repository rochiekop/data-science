
CREATE TABLE sales (
	id_transaksi INT,
    id_customer int,
    id_barang VARCHAR(15),
    tgl_transaksi DATE,
    jumlah_pembayaran INT,
    diskon INT
);

INSERT INTO sales VALUES (1, 1123, 'S10-1678', '2021-09-01', 500000, 10),
						 (2, 1147, 'S12-1871', '2021-09-01', 247000, 15),
						 (3, 1147, 'S10-1678', '2021-10-02', 325000, 10),
						 (4, 1189, 'S10-1678', '2021-10-05', 440000, 0),
						 (5, 1176, 'S12-1871', '2021-10-08', 122000, 10),
                         (6, 1187, 'S12-1871', '2021-11-03', 870000, 20),
                         (7, 1123, 'S10-1678', '2021-11-06', 457000, 0),
						 (8, 1135, 'S12-1871', '2021-11-12', 142000, 15);
						 
CREATE TABLE customers2(
	id_customer INT,
    nama_customer VARCHAR(50),
    kota VARCHAR(50),
    email VARCHAR(50),
    PRIMARY KEY(id_customer)
);

INSERT INTO customers2 VALUES (1123, 'Reihan', 'Jakarta Barat', 'reihan@gmail.com'),
							 (1126, 'Abra', 'Depok', 'abra@yahoo.com'),
                             (1147, 'Beni', 'Jakarta Selatan', 'beni@gmail.com'),
                             (1156, 'Lufi', 'Jakarta Selatan', 'lufi@ymail.com'),
                             (1189, 'Kaido', 'Depok', 'kaido@gmail.com');