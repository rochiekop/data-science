
CREATE TABLE payments(
	custID INT,
    checkID VARCHAR(25),
    amount INT
);

INSERT INTO payments values (103, 'HQ336', 60);
INSERT INTO payments values (112, 'JM555', 74);
INSERT INTO payments values (112, 'BO864', 75);
INSERT INTO payments values (119, 'DB933', 14);


CREATE TABLE shoes(
	ShoeName VARCHAR(25),
    Stocks INT,
    Profit INT
);

INSERT INTO shoes VALUES('AbabilStrong', 2304, 2344);
INSERT INTO shoes VALUES('Trek', 5334, 7455);
INSERT INTO shoes VALUES('Fly', 1023, 5001);
INSERT INTO shoes VALUES('Fast', 3231, 3123);

CREATE TABLE pendapatan(
	Nama VARCHAR(25),
    Genger VARCHAR(25),
    Income INT
);

INSERT INTO pendapatan VALUES ('Anton', 'Male', NULL);
INSERT INTO pendapatan VALUES ('Arga', NULL, 7455);
INSERT INTO pendapatan VALUES ('Lina', NULL, 5001);
INSERT INTO pendapatan VALUES (NULL, 'Female', 3123);

CREATE TABLE pendapatan2(
	Nama VARCHAR(25),
    Genger VARCHAR(25),
    Income INT
);

INSERT INTO pendapatan2 VALUES ('Anton', 'Male', NULL);
INSERT INTO pendapatan2 VALUES ('Arga', NULL, NULL);
INSERT INTO pendapatan2 VALUES ('Lina', NULL, NULL);
INSERT INTO pendapatan2 VALUES (NULL, 'Female', NULL);

CREATE TABLE stock(
	Kategori VARCHAR(25),
    Jumlah INT
);

INSERT INTO stock VALUES ('Baju', 20);
INSERT INTO stock VALUES ('Celana', 40);
INSERT INTO stock VALUES ('Baju', 15);
INSERT INTO stock VALUES ('Topi', 30);
INSERT INTO stock VALUES ('Topi', 35);
INSERT INTO stock VALUES ('Celana', 25);

CREATE TABLE medals(
	Name VARCHAR(25),
    Sport VARCHAR(25),
    Country VARCHAR(25),
    Medal INT
);

INSERT INTO medals VALUES ('Dottu', 'Badminton', 'Indonesia', 3);
INSERT INTO medals VALUES ('Nova', 'Basketball', 'Indonesia', 4);
INSERT INTO medals VALUES ('Novo', 'Basketball', 'Indonesia', 2);
INSERT INTO medals VALUES ('Baba', 'Badminton', 'Philippine', 3);
INSERT INTO medals VALUES ('Bubu', 'Badminton', 'Indonesia', 1);
INSERT INTO medals VALUES ('Detto', 'Basketball', 'Philippine', 1);
INSERT INTO medals VALUES ('Papi', 'Badminton', 'Philippine', 3);
INSERT INTO medals VALUES ('Pepo', 'Basketball', 'Philippine', 8);

-- Window Function
CREATE TABLE temp(
	City VARCHAR(25),
    Date DATE,
    Temp INT
);

INSERT INTO temp VALUES('City A', '2001-1-1', 25);
INSERT INTO temp VALUES('City B', '2001-1-1', 22);
INSERT INTO temp VALUES('City A', '2001-1-2', 30);
INSERT INTO temp VALUES('City B', '2001-1-2', 27);