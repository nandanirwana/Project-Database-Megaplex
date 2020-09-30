CREATE DATABASE projectDBblytzMegaplex

USE projectDBblytzMegaplex


-- CREATE

CREATE TABLE Staff(
	StaffID CHAR(5) PRIMARY KEY CHECK(StaffID LIKE 'SF[0-9][0-9][0-9]'),
	StaffName VARCHAR(30) CHECK(LEN(StaffName)>=7 AND LEN(StaffName)<= 30) NOT NULL,
	StaffEmail VARCHAR(40) NOT NULL,
	StaffAddress VARCHAR(50) NOT NULL,
	StaffDOB DATE CHECK(DATEDIFF(YEAR, StaffDOB, GETDATE()) >= 18 ),
	StaffPhone VARCHAR(15) NOT NULL,
	StaffGender VARCHAR(10) CHECK(StaffGender LIKE 'Male' or StaffGender LIKE 'Female')
)

CREATE TABLE Movie(
	MovieID CHAR(5) PRIMARY KEY CHECK(MovieID LIKE 'MV[0-9][0-9][0-9]'),
	MovieName VARCHAR(30) NOT NULL,
	LisenceNumber VARCHAR(30) NOT NULL,
	MovieDuration INT CHECK(MovieDuration <= 240)
)

CREATE TABLE Studio(
	StudioID CHAR(5) PRIMARY KEY CHECK(StudioID LIKE 'ST[0-9][0-9][0-9]'),
	StudioName VARCHAR(30) NOT NULL,
	StudioPrice INT CHECK(StudioPrice >= 35000 AND StudioPrice <= 65000)
)

CREATE TABLE RefreshmentType(
	RTID CHAR(5) PRIMARY KEY CHECK(RTID LIKE 'RT[0-9][0-9][0-9]'),
	RTTypeName VARCHAR(30) NOT NULL
)

CREATE TABLE ScaduleTransaction(
	STID CHAR(5) PRIMARY KEY CHECK(STID LIKE 'MS[0-9][0-9][0-9]'),
	MovieID CHAR(5) FOREIGN KEY REFERENCES Movie(MovieID),
	StudioID CHAR(5) FOREIGN KEY REFERENCES Studio(StudioID),
	ShowtimeDate DATE CHECK (DATEDIFF(DAY, GETDATE(), ShowtimeDate) >= 7),
	ShowtimeTime TIME
)

CREATE TABLE Refreshment(
	RefreshmentID CHAR(5) PRIMARY KEY CHECK(RefreshmentID LIKE 'RE[0-9][0-9][0-9]'),
	RTID CHAR(5),
	RefreshmentName VARCHAR(30) NOT NULL,
	RefreshmentPrice INT NOT NULL,
	RefreshmentStock INT CHECK(RefreshmentStock > 50),
	CONSTRAINT FK_RTID  FOREIGN KEY(RTID) REFERENCES RefreshmentType(RTID)
)


CREATE TABLE MovieSaleTransaction(
	MSTID CHAR(6) PRIMARY KEY CHECK(MSTID LIKE 'MTr[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID),
	MSTTransactionDate DATE
)

CREATE TABLE RefreshmentSaleTransaction(
	RSTID CHAR(6) PRIMARY KEY CHECK(RSTID LIKE 'RTr[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES Staff(StaffID),
	RefreshmentTransactionDate DATE
)

CREATE TABLE DetailRefreshmentTransaction(
	RefreshmentID CHAR(5),
	RSTID CHAR(6),
	Quantity INT,
	CONSTRAINT FK_RefreshmentID FOREIGN KEY(RefreshmentID) REFERENCES Refreshment(RefreshmentID),
	CONSTRAINT FK_RSTID FOREIGN KEY(RSTID) REFERENCES RefreshmentSaleTransaction(RSTID),
	PRIMARY KEY(RefreshmentID, RSTID)
)

CREATE TABLE DetailMovieSaleTransaction(
	MSTID CHAR(6),
	STID CHAR(5),
	SeatSold INT,
	CONSTRAINT FK_MSTID FOREIGN KEY(MSTID) REFERENCES MovieSaleTransaction(MSTID),
	CONSTRAINT FK_STID FOREIGN KEY(STID) REFERENCES ScaduleTransaction(STID),
	PRIMARY KEY(MSTID, STID)
)


-- INSERT

INSERT INTO Staff
VALUES ('SF001', 'Alvita Cantik', 'alvita@cantik.com', 'jl.bikini buttom', convert(date, '19971118', 112), '0811324563789', 'Female')
INSERT INTO Staff
Values
('SF002', 'Nanda Cantik', 'Nanda@cantik.com', 'jl. cipinang no.14',convert(date, '20001117', 112), '0811324588889', 'Female'), 
('SF003', 'Spongebob', 'square@pants.com', 'jl.bikini buttom',convert(date,'19960316', 112), '08888884563789', 'Male'), 
('SF004', 'Patrick', 'Patrick@gmail.com', 'jl.bikini buttom',convert(date,'19961230', 112), '081199i563789', 'Male'), 
('SF005', 'Squidward', 'Squid@ward.com', 'jl.bikini buttom',convert(date,'19631231', 112), '0899024563789', 'Male'), 
('SF006', 'Gary Si Siput', 'Gary@Siput.com', 'jl.bikini buttom',convert(date, '20001017', 112), '089990563789', 'Female'), 
('SF007', 'Doraemon', 'doraemon@gmail.com', 'jl.Jepang no.11',convert(date,'19991212', 112), '0811329993789', 'Male'), 
('SF008', 'Hello Kitty', 'Hello@Kitty.com', 'jl.Pegangsaan Timur', convert(date, '19931211', 112), '0811979797789', 'Female'), 
('SF009', 'Kim Nam Joon', 'Namjoon@gmail.com', 'jl.korea no. 11',convert(date, '19940912', 112), '081909034563789', 'Male'), 
('SF010', 'Kim Soek Jin', 'Jin@gmail.com', 'jl.korea no.12',convert(date,'19921204', 112), '0811326883789', 'Male'), 
('SF011', 'Min Yoong Gi', 'suga@gmail.com', 'jl.South korea',convert(date, '19930309', 112), '0811345663789', 'Male'), 
('SF012', 'Jong Ho Soek', 'jhope@gmail.com', 'jl.South korea',convert(date, '19940218', 112), '08123454563789', 'Male'), 
('SF013', 'Park Jimin', 'jimin@gmail.com', 'jl. South korea', convert(date, '19951013', 112), '08123124563789', 'Male'), 
('SF014', 'Kim Tae Hyung', 'v@gmail.com', 'jl. South korea', convert(date, '19951230', 112), '08113455663789', 'Male'), 
('SF015', 'Jeon Jung Kook', 'jungkook@gmail.com', 'jl. South korea', convert(date, '19970901', 112), '089967324563789', 'Male')

UPDATE Staff SET StaffName = 'Spongebob Square Pants' WHERE StaffName = 'Spongebob'

UPDATE Staff SET StaffName = 'Patrick Star' WHERE StaffName = 'Patrick'

UPDATE Staff SET StaffName = 'Squidward Squid' WHERE StaffName = 'Squidward'

UPDATE Staff SET StaffName = 'Doraemon Nobita' WHERE StaffName = 'Doraemon'

INSERT INTO RefreshmentType
VALUES ('RT001', 'Coffee'), ('RT002', 'Soda'), ('RT003', 'Juice') , ('RT004', 'Tea'), ('RT005', 'Other Beverages'),
('RT006', 'Western Food'), ('RT007', 'Heavy Snacks'), ('RT008', 'Traditional Food'), ('RT009', 'Eastern Food'), 
('RT010', 'Light Snacks')

SELECT * FROM Movie
INSERT INTO Movie
VALUES ('MV001', 'La la Land', '123456789', 120), ('MV002', 'Ugly Duckling', '12345673910', 100), 
('MV015', 'U-Prince', '123450789', 110), ('MV003', 'Avangers', '120456789', 120), ('MV004', 'Avangers 2', '103456789', 105), 
('MV005', 'Meteor Garden', '126456789', 130), ('MV006', 'Chalie Angel', '123450789', 127), ('MV007', 'Joker', '023456789', 110), 
('MV008', 'Dont', '123458789', 90), ('MV009', 'Aladin', '003456789', 130), ('MV010', 'Greatest Showman', '000456789', 120), 
('MV011', 'Avangers 3', '123656789', 100), ('MV012', 'Lion king', '123456009', 120), ('MV013', 'Frozen 2', '123006789', 150), 
('MV014', 'Frozen', '123000789', 130)


SELECT * FROM Studio
INSERT INTO Studio
VALUES ('ST001', 'StudioA', 40000), ('ST002', 'StudioB', 50000), ('ST003', 'StudioC', 45000), ('ST004', 'StudioD', 60000), 
('ST005', 'StudioE', 60000), ('ST006', 'StudioF', 55000), ('ST007', 'StudioG', 50000), ('ST008', 'StudioH', 45000), 
('ST009', 'StudioI', 60000), ('ST010', 'StudioJ', 60000), ('ST011', 'StudioK', 45000), ('ST012', 'StudioL', 40000), 
('ST013', 'StudioO', 60000), ('ST014', 'StudioN', 55000), ('ST015', 'StudioM', 45000)

INSERT INTO ScaduleTransaction
VALUES ('MS016', 'MV001', 'ST001', '02-mar-2020','10:30'),
('MS002', 'MV002', 'ST002','30-Jan-2020', '9:34'), 
('MS003', 'MV003', 'ST003', '01-Mar-2020','8:35'), 
('MS004', 'MV004', 'ST004', '20-Feb-2020','7:30'), 
('MS005', 'MV005', 'ST005', '03-Mar-2020','6:30'), 
('MS006', 'MV006', 'ST006', '14-Jul-2020','5:55'), 
('MS008', 'MV007', 'ST007', '15-Jul-2020','4:45'), 
('MS007', 'MV008', 'ST008', '02-Mar-2020','3:25'), 
('MS009', 'MV009', 'ST009', '13-Mar-2020','2:37'), 
('MS010', 'MV010', 'ST010', '16-Mar-2020','1:30'), 
('MS012', 'MV011', 'ST011', '17-Nov-2020','00:30'), 
('MS011', 'MV012', 'ST012', '18-Nov-2020','11:15'), 
('MS013', 'MV013', 'ST013', '19-Nov-2020','10:35'), 
('MS014', 'MV014', 'ST014', '16-Nov-2020','8:30'), 
('MS015', 'MV015', 'ST015', '15-Nov-2020','7:00')

SELECT * FROM Refreshment
INSERT INTO Refreshment
Values ('RE001', 'RT001', 'Latte', 15000, 60), ('RE002', 'RT001', 'Expreso', 15000, 60), ('RE003', 'RT002', 'Fanta', 15000, 60), 
('RE004', 'RT003', 'Orange Juice', 15000, 70), ('RE005', 'RT004', 'Ice Tea', 15000, 60), ('RE006', 'RT004', 'Green Tea', 15000, 70), 
('RE007', 'RT006', 'Spagetti', 15000, 60), ('RE010', 'RT008', 'Nasi Padang', 15000, 60), ('RE013', 'RT008', 'Seblak', 15000, 70), 
('RE008', 'RT010', 'Chiki', 15000, 75), ('RE011', 'RT005', 'Ice Cream', 15000, 60), ('RE014', 'RT010', 'Popcorn', 15000, 65), 
('RE009', 'RT008', 'Kondro', 15000, 80), ('RE012', 'RT008', 'Coto', 15000, 80), ('RE015', 'RT008', 'Pallubasa', 15000, 80)


INSERT INTO MovieSaleTransaction
Values ('MTr001', 'SF001', '01-Jan-2020'), ('MTr002', 'SF002', '02-Jan-2020'),
('MTr003', 'SF003', '03-Jan-2020'), ('MTr004', 'SF004', '04-Jan-2020'),
('MTr005', 'SF005', '05-Jan-2020'), ('MTr006', 'SF006', '06-Jan-2020'),
('MTr007', 'SF007', '07-Jan-2020'), ('MTr008', 'SF008', '08-Jan-2020'),
('MTr009', 'SF009', '09-Jan-2020'), ('MTr010', 'SF010', '10-Jan-2020'),
('MTr011', 'SF011', '13-Jan-2020'), ('MTr012', 'SF012', '11-Jan-2020'),
('MTr013', 'SF013', '14-Jan-2020'), ('MTr014', 'SF014', '12-Jan-2020'),
('MTr015', 'SF015', '15-Jan-2020')


INSERT INTO RefreshmentSaleTransaction
Values ('RTr001', 'SF001', '01-Jan-2020'), ('RTr002', 'SF002', '02-Jan-2020'), 
('RTr003', 'SF003', '03-Jan-2020'), ('RTr010', 'SF010', '10-Jan-2020'), 
('RTr004', 'SF004', '04-Jan-2020'), ('RTr011', 'SF011', '11-Jan-2020'), 
('RTr005', 'SF005', '05-Jan-2020'), ('RTr012', 'SF012', '12-Jan-2020'), 
('RTr006', 'SF006', '06-Jan-2020'), ('RTr013', 'SF013', '13-Jan-2020'), 
('RTr007', 'SF007', '07-Jan-2020'), ('RTr014', 'SF014', '14-Jan-2020'), 
('RTr008', 'SF008', '08-Jan-2020'), ('RTr015', 'SF015', '15-Jan-2020'), 
('RTr009', 'SF009', '09-Jan-2020')


INSERT INTO DetailMovieSaleTransaction
VALUES ('MTr001', 'MS016', 2), ('MTr002', 'MS002', 2), ('MTr003', 'MS003', 2), ('MTr004', 'MS004', 1), 
('MTr005', 'MS005', 1), ('MTr006', 'MS011', 4), ('MTr003', 'MS016', 2), ('MTr008', 'MS006', 1), 
('MTr009', 'MS006', 2), ('MTr014', 'MS012', 2), ('MTr004', 'MS002', 2), ('MTr009', 'MS007', 1), 
('MTr010', 'MS007', 3), ('MTr015', 'MS013', 5), ('MTr005', 'MS003', 2), ('MTr010', 'MS008', 4), 
('MTr011', 'MS008', 1), ('MTr001', 'MS014', 2), ('MTr006', 'MS004', 2), ('MTr011', 'MS009', 3), 
('MTr012', 'MS009', 2), ('MTr002', 'MS015', 1), ('MTr007', 'MS005', 2), ('MTr012', 'MS010', 5), 
('MTr013', 'MS010', 3)


SELECT * FROM DetailRefreshmentTransaction
INSERT INTO DetailRefreshmentTransaction
VALUES ('RE001', 'RTr001', 2), ('RE002', 'RTr002', 2), ('RE003', 'RTr003', 1), ('RE004', 'RTr004', 1), 
('RE005', 'RTr005', 1), ('RE011', 'RTr011', 1), ('RE015', 'RTr001', 1), ('RE010', 'RTr006', 1), 
('RE006', 'RTr006', 3), ('RE012', 'RTr012', 3), ('RE014', 'RTr002', 3), ('RE009', 'RTr007', 3), 
('RE007', 'RTr007', 4), ('RE013', 'RTr013', 4), ('RE013', 'RTr003', 4), ('RE008', 'RTr008', 4), 
('RE007', 'RTr008', 5), ('RE014', 'RTr014', 5), ('RE012', 'RTr004', 5), ('RE007', 'RTr009', 5), 
('RE009', 'RTr009', 1), ('RE015', 'RTr015', 2), ('RE011', 'RTr005', 2), ('RE006', 'RTr010', 2), 
('RE010', 'RTr010', 2)


-- Simulation

INSERT INTO DetailMovieSaleTransaction
VALUES ('MTr015', 'MS016', 2), ('MTr014', 'MS002', 2), ('MTr013', 'MS003', 2), ('MTr012', 'MS004', 1), 
('MTr011', 'MS005', 1), ('MTr009', 'MS011', 4), ('MTr009', 'MS016', 2), ('MTr009', 'MS015', 1), 
('MTr010', 'MS006', 2), ('MTr008', 'MS012', 2), ('MTr014', 'MS015', 2), ('MTr008', 'MS007', 1), 
('MTr004', 'MS007', 3), ('MTr007', 'MS013', 5), ('MTr013', 'MS014', 2), ('MTr007', 'MS008', 4), 
('MTr003', 'MS008', 1), ('MTr006', 'MS014', 2), ('MTr012', 'MS013', 2), ('MTr006', 'MS009', 3), 
('MTr002', 'MS009', 2), ('MTr005', 'MS015', 1), ('MTr011', 'MS012', 2), ('MTr005', 'MS010', 5), 
('MTr001', 'MS010', 3)


INSERT INTO DetailRefreshmentTransaction
VALUES ('RE001', 'RTr015', 2), ('RE002', 'RTr014', 2), ('RE003', 'RTr013', 1), ('RE001', 'RTr004', 1), 
('RE005', 'RTr011', 1), ('RE011', 'RTr001', 1), ('RE010', 'RTr001', 1), ('RE006', 'RTr001', 1), 
('RE006', 'RTr011', 3), ('RE012', 'RTr008', 3), ('RE002', 'RTr001', 3), ('RE007', 'RTr001', 3), 
('RE007', 'RTr002', 4), ('RE013', 'RTr005', 4), ('RE003', 'RTr005', 4), ('RE009', 'RTr008', 4), 
('RE007', 'RTr012', 5), ('RE014', 'RTr007', 5), ('RE004', 'RTr006', 5), ('RE010', 'RTr009', 5), 
('RE009', 'RTr001', 1), ('RE015', 'RTr007', 2), ('RE005', 'RTr008', 2), ('RE011', 'RTr010', 2), 
('RE010', 'RTr005', 2)


-- 10 Cases

--1
SELECT MovieID, [Total Revenue] = 'IDR '+ CAST((SUM(SeatSold)*StudioPrice) AS varchar) 
FROM ScaduleTransaction sct, Studio st, DetailMovieSaleTransaction dmst
WHERE DATEPART(DAY, ShowtimeDate) < 20
AND sct.StudioID = st.StudioID
AND sct.STID = dmst.STID
AND StudioPrice > 50000
GROUP BY MovieID, StudioPrice

--2
SELECT StaffName, [Total Sold Seat] = (SUM(SeatSold))
FROM Staff sf, MovieSaleTransaction mst, DetailMovieSaleTransaction dmst
WHERE StaffGender LIKE 'Male'
AND sf.StaffID = mst.StaffID
AND mst.MSTID = dmst.MSTID
AND DATEPART(DAY, MSTTransactionDate) < 28
GROUP BY StaffName
ORDER BY [Total Sold Seat] desc

--3
SELECT DISTINCT [Average Refreshment Revenue per Day] = 'IDR '+ CAST(AVG(Quantity)*RefreshmentPrice AS varchar),
[Transaction Days] = CAST(COUNT(RefreshmentTransactionDate) AS VARCHAR) + ' days', [Female Staff Count] = CAST(COUNT(sf.StaffID) AS VARCHAR) + ' people'
FROM DetailRefreshmentTransaction dft, Refreshment rf, Staff sf, RefreshmentSaleTransaction rst
WHERE StaffGender LIKE 'Female'
AND rst.RSTID = dft.RSTID
AND rf.RefreshmentID = dft.RefreshmentID
AND rst.StaffID = sf.StaffID
AND RefreshmentTransactionDate < '20200210'
GROUP BY RefreshmentPrice

--4. Display Staff First Name (started with ‘Mr. ’ added with staff’s first name), Total of Refreshment (obtainend  from count of refreshment), Total of Quantity Sold (obtained from sum of quantity) for every transaction handled by male staff. Then combine it with Staff First Name (started with ‘Ms. ’ added with staff’s first name), Total of Refreshment (obtained  from count of refreshment), Total of Quantity Sold (obtained from sum of quantity) for every transaction handled by female staff.

SELECT [Staff First Name] = 'Mr. ' + SUBSTRING(StaffName, 1, (CHARINDEX(' ', StaffName))), [Total of Refreshment] = COUNT(drt.RefreshmentID), [Total Quantity Sold] = SUM(Quantity)
FROM Staff sf, Refreshment rf, DetailRefreshmentTransaction drt, RefreshmentSaleTransaction rst
WHERE StaffGender LIKE 'Male'
AND sf.StaffID = rst.StaffID
AND rst.RSTID = drt.RSTID
AND rf.RefreshmentID = drt.RefreshmentID
GROUP BY StaffName
UNION
SELECT [Staff First Name] = 'Ms. ' + SUBSTRING(StaffName, 1, (CHARINDEX(' ', StaffName))), [Total of Refreshment] = COUNT(drt.RefreshmentID), [Total Quantity Sold] = SUM(Quantity)
FROM Staff sf, Refreshment rf, DetailRefreshmentTransaction drt, RefreshmentSaleTransaction rst
WHERE StaffGender LIKE 'Female'
AND sf.StaffID = rst.StaffID
AND rst.RSTID = drt.RSTID
AND rf.RefreshmentID = drt.RefreshmentID
GROUP BY StaffName



--5.	Display Refreshment Transaction ID (obtained from last three number of Transaction ID), Refreshment Transaction Date (obtained from transaction date in ‘mon dd, yyyy’ format) for every refreshment transaction which quantity multiplied by refreshment price is more than average quantity multiplied by refreshment price and refreshment type ID is either ‘RT006’, ‘RT007’, ‘RT008’, ‘RT009’, or ‘RT010’.  (alias subquery)

SELECT 'Refreshment Transaction ID' = RIGHT(rst.RSTID, 3), 'Refreshment Transaction Date' = CONVERT(VARCHAR, RefreshmentTransactionDate, 107)
FROM RefreshmentSaleTransaction rst
JOIN DetailRefreshmentTransaction drt
ON rst.RSTID = drt.RSTID
JOIN Refreshment rf
ON drt.RefreshmentID = rf.RefreshmentID
JOIN RefreshmentType rt
ON rf.RTID = rt.RTID
,(
	SELECT 'AVQuantity' = AVG(Quantity) * RefreshmentPrice
	FROM DetailRefreshmentTransaction drt
	JOIN Refreshment rf
	ON drt.RefreshmentID = rf.RefreshmentID
	GROUP BY RefreshmentPrice
) AS A
WHERE ((Quantity * RefreshmentPrice) > A.AVQuantity)
AND (rt.RTID IN ('RT006', 'RT007', 'RT008', 'RT009', 'RT010'))

--6.	Transaction Date (added with the weekday name of transaction date, added with ‘, ‘ and the transaction date itself in ‘dd mon yyyy’ format) and Total Movie Revenue (started with ‘IDR ‘ and combined with total seats multiplied with studio price) for every transaction which less than 30 days before 28 February 2020 and Total Movie Revenue exceeds average seats multiplied by studio price. (alias subquery)
SELECT [Transaction Date] = DATENAME(DW, MSTTransactionDate) + ', ' + CONVERT(varchar, MSTTransactionDate, 106),[Total Movie Revenue] = 'IDR ' + CONVERT(varchar,alias.totalseats)
FROM MovieSaleTransaction mst JOIN DetailMovieSaleTransaction dmt
ON mst.MSTId = dmt.MSTId 
JOIN ScaduleTransaction st 
ON st.STId = dmt.STId 
JOIN Studio stu 
ON stu.StudioId = st.StudioId,(
	SELECT totalseats = SUM(SeatSold*StudioPrice),
	averageseats = AVG(SeatSold*StudioPrice)
	FROM MovieSaleTransaction mst 
	JOIN DetailMovieSaleTransaction dmst 
	ON mst.MSTId = dmst.MSTId 
	JOIN ScaduleTransaction st 
	ON st.STId = dmst.STId 
	JOIN Studio stu ON stu.StudioId = st.StudioId
) as alias
WHERE alias.totalseats > alias.averageseats  
AND DAY(MSTTransactionDate) < 30 AND MSTTransactionDate < '2020/02/28'

-- 7.	Display Staff Last Name (obtained from staff’s last name), RefreshmentTransactionId, RefreshmentName and Price (obtained by adding ‘IDR ‘ in front of the refreshment price) for every transaction which price is more than minimum price of refreshments available for sold and is less than maximum price of refreshments available for sold. (alias subquery)

SELECT [Staff Last Name] = RIGHT(StaffName , CHARINDEX(' ', REVERSE(StaffName))),
rst.RSTID, RefreshmentName, [Price] = 'IDR' + CAST(RefreshmentPrice AS VARCHAR)
FROM Staff s
JOIN RefreshmentSaleTransaction rst
	ON s.StaffID = rst.StaffID
JOIN DetailRefreshmentTransaction drt
	ON rst.RSTID = drt.RSTID
JOIN Refreshment r
	ON drt.RefreshmentID = r.RefreshmentID
, (
	SELECT [MinPrice] = MIN(RefreshmentPrice)
	FROM Refreshment
) AS A
,( 
	SELECT [MaxPrice] = MAX(RefreshmentPrice)
	FROM Refreshment
) AS B
WHERE (RefreshmentPrice > A.MinPrice) AND (RefreshmentPrice < B.MaxPrice)

-- 8.	Display Movie Transaction ID (obtained by removing ‘M’ from movie transaction ID and adding ‘ ‘ before last three numbers of the ID), StudioName and Studio Price from (obtained by adding ‘IDR ‘ in front of the studio price) for every transaction which seats bought is between average seats bought and maximum seats bought, and studio price between average studio price and maximum studio price. (alias subquery)

SELECT
[Movie Transaction Id] = SUBSTRING(mst.MSTID,CHARINDEX('T', mst.MSTID),2) + ' ' + RIGHT(mst.MSTID,3),
StudioName,
StudioPrice = 'IDR ' + CAST(StudioPrice AS VARCHAR)
FROM MovieSaleTransaction mst JOIN DetailMovieSaleTransaction dmst
ON mst.MSTID = dmst.MSTID 
JOIN ScaduleTransaction st 
ON dmst.STID = st.STID 
JOIN Studio std 
ON std.StudioId = st.StudioId,
(
	SELECT averageSeats = AVG(SeatSold),
	maxSeat = MAX(SeatSold),
	averagePrice = AVG(StudioPrice),
	maxPrice = MAX(StudioPrice)
	FROM MovieSaleTransaction mst JOIN DetailMovieSaleTransaction dmst ON
	mst.MSTID = dmst.MSTID JOIN ScaduleTransaction st ON
	dmst.STID = st.STID JOIN Studio std ON
	std.StudioID = st.StudioID
) AS alias
WHERE SeatSold BETWEEN alias.averageSeats AND alias.maxSeat 
AND StudioPrice BETWEEN alias.averagePrice AND maxPrice


-- 9.	Create a view named ‘Movie Schedule Viewer’ to display Studio ID (obtained by replacing ‘ST’ in Studio ID replaced  with ‘Studio ‘), StudioName, Total Play Schedule (obtained from total count of movie schedules), and Movie Duration   Total (obtained from total sum of movie duration) for Studios which name started with ‘Satin’ and movie duration is  longer than 120  minutes.

CREATE VIEW [Movie Schedule Viewer] AS 
SELECT StudioId = REPLACE(std.StudioId,'ST', 'Studio'), StudioName, [Total Play Schedule] = COUNT(dmst.STID),[Movie Duration Total] = CONVERT(TIME(0),DATEADD(S,SUM(MovieDuration*60),0))
FROM Studio std 
JOIN ScaduleTransaction st
ON std.StudioId = st.StudioId 
JOIN Movie mv 
ON mv.MovieId = st.MovieId 
JOIN DetailMovieSaleTransaction dmst
ON dmst.STID = st.STId 
JOIN MovieSaleTransaction mst 
ON mst.MSTId = dmst.MSTId
WHERE StudioName LIKE 'Satin%' AND (MovieDuration) < 120
GROUP BY std.StudioId, StudioName


--10.	Create a view named ‘Refreshment Transaction Summary Viewer’ to display Transaction Count (obtained from total count of refreshment transactions and combined with ‘ transactions’), Quantity Sold (obtained from total sum of quantity and ended with ‘ products’) for transactions which happened on ‘Saturday’ or ‘Sunday’ and quantity is more than 5.

CREATE VIEW [Refreshment Transaction Summary Viewers] AS
SELECT
[Transaction Count] = CAST(COUNT(rst.RSTID) AS VARCHAR) + ' transactions', [Quantity Sold] = CAST(SUM(Quantity) AS VARCHAR) + ' products'
FROM RefreshmentSaleTransaction rst, DetailRefreshmentTransaction drt
WHERE rst.RSTID = drt.RSTID
AND DATENAME(WEEKDAY, RefreshmentTransactionDate) = 'Saturday' OR DATENAME(WEEKDAY, RefreshmentTransactionDate) = 'Sunday'