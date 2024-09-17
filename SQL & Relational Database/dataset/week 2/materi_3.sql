CREATE TABLE customers(
	id_customer INT,
    nama_customer VARCHAR(50),
    kota VARCHAR(50),
    PRIMARY KEY(id_customer)
);

INSERT INTO customers VALUES (1123, 'Reihan', 'Jakarta Barat'),
							 (1126, 'Abra', 'Depok'),
                             (1147, 'Beni', 'Jakarta Selatan'),
                             (1156, 'Lufi', 'Jakarta Selatan'),
                             (1189, 'Kaido', 'Depok');

CREATE TABLE payments(
	id_customer INT,
    id_transaksi INT,
    tgl_transaksi DATE,
    jumlah_pembayaran INT,
    PRIMARY KEY(id_transaksi)
);

INSERT INTO payments VALUES (1123, 1, '2021-09-01', 500000),
							(1147, 2, '2021-09-01', 247000),
                            (1147, 3, '2021-09-02', 325000),
                            (1189, 4, '2021-09-03', 440000),
                            (1176, 5, '2021-09-03', 122000);
