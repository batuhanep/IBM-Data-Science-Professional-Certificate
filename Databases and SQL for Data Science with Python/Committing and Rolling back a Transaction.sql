--Committing and Rolling back a Transaction
--STORED PROCEDURES, ACID TRANSACTIONS


DROP TABLE IF EXISTS ShoeShop;


CREATE TABLE ShoeShop (
    Product VARCHAR(25) NOT NULL,
    Stock INTEGER NOT NULL,
    Price DECIMAL(8,2) CHECK(Price>0) NOT NULL,
    PRIMARY KEY (Product)
    );

INSERT INTO ShoeShop VALUES
('Boots',11,200),
('High heels',8,600),
('Brogues',10,150),
('Trainers',14,300);



SELECT * FROM ShoeShop;

DROP TABLE IF EXISTS BankAccounts;


CREATE TABLE BankAccounts (
    AccountNumber VARCHAR(5) NOT NULL,
    AccountName VARCHAR(25) NOT NULL,
    Balance DECIMAL(8,2) CHECK(Balance>=0) NOT NULL,
    PRIMARY KEY (AccountNumber)
    );


    
INSERT INTO BankAccounts VALUES
('B001','Rose',300),
('B002','James',1345),
('B003','Shoe Shop',124200),
('B004','Corner Shop',76000);

-- Retrieve all records from the table

SELECT * FROM BankAccounts;

--A transaction is simply a sequence of operations performed using one or more SQL statements as a single logical unit of work. A database transaction must be ACID (Atomic, Consistent, Isolated and Durable). The effects of all the SQL statements in a transaction can either be applied to the database using the COMMIT command or undone from the database using the ROLLBACK command.
--BEGIN DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; RESIGNAL; END; 
--Bu k�s�m, SQLEXCEPTION hatas� olu�mas� durumunda �al��t�r�lacak hata i�leyicisini tan�mlamaktad�r. Hata i�leyicisi, �ncelikle yap�lan t�m de�i�iklikleri geri al�r (rollback), ard�ndan hatay� yeniden yayar (resignal). Hatay� yeniden yaymak, hatan�n prosed�r� �a��ran koda iletilmesini sa�lar.
--Bu kod, Rose'un banka hesab�ndan Ayakkab� Ma�azas�'n�n banka hesab�na para transfer eden ve Ayakkab� Ma�azas�'ndaki bot stokunu g�ncelleyen bir SQL stored procedure'�d�r.

DELIMITER //

CREATE PROCEDURE TRANSACTION_ROSE()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    START TRANSACTION;
    UPDATE BankAccounts
    SET Balance = Balance-200
    WHERE AccountName = 'Rose';

    UPDATE BankAccounts
    SET Balance = Balance+200
    WHERE AccountName = 'Shoe Shop';

    UPDATE ShoeShop
    SET Stock = Stock-1
    WHERE Product = 'Boots';

    UPDATE BankAccounts
    SET Balance = Balance-300
    WHERE AccountName = 'Rose';

    COMMIT;
END //

DELIMITER ;

--Ad�m ad�m a��klama:
--CREATE PROCEDURE TRANSACTION_ROSE() Bu ifade, TRANSACTION_ROSE() adl� bir stored procedure olu�turur. Stored procedure'ler, tek bir ifadeyle y�r�t�lebilen yeniden kullan�labilir SQL kod bloklar�d�r. BEGIN Bu ifade, stored procedure g�vdesinin ba�lang�c�n� i�aret eder. DECLARE EXIT HANDLER FOR SQLEXCEPTION Bu ifade, SQLEXCEPTION s�n�f� i�in bir istisna i�leticisi tan�mlar. Bu, stored procedure y�r�t�l�rken herhangi bir SQL hatas� olu�ursa, istisna i�leticisi i�indeki kodun y�r�t�lece�i anlam�na gelir. ROLLBACK Bu ifade, i�lem ba�lad���ndan beri veritaban�na yap�lan t�m de�i�iklikleri geri al�r. RESIGNAL Bu ifade, istisnay� yeniden y�kseltir, b�ylece �a�r�yan kod onu i�leyebilir. START TRANSACTION Bu ifade, yeni bir veritaban� i�lemi ba�lat�r. Bir i�lem, tek bir birim olarak ele al�nan bir grup veritaban� i�lemidir. ��lem s�ras�nda veritaban�na yap�lan t�m de�i�iklikler, i�lemin sonunda ya kaydedilir ya da geri al�n�r.  COMMIT Bu ifade, i�lemi onaylar, veritaban�na yap�lan t�m de�i�iklikleri kal�c� hale getirir. END Bu ifade, stored procedure g�vdesinin sonunu i�aret eder. DELIMITER ; Bu ifade, ay�r�c�y� tekrar noktal� virg�l karakterine ayarlar.

--now check if the transaction can successfully be committed or not. 

CALL TRANSACTION_ROSE;

SELECT * FROM BankAccounts;

SELECT * FROM ShoeShop;

--Observe that the transaction has been executed. But when we observe the tables, no changes have permanently been saved through COMMIT. All the possible changes happened might have been undone through ROLLBACK since the whole transaction fails due to the failure of a SQL statement or more. Let's go through the possible reason behind the failure of the transaction and how COMMIT - ROLLBACK works on a stored procedure:
--The first three UPDATEs should run successfully. Both the balance of Rose and ShoeShop should have been updated in the BankAccounts table. The current balance of Rose should stand at 300 - 200 (price of a pair of Boots) = 100. The current balance of ShoeShop should stand at 124,200 + 200 = 124,400. The stock of Boots should also be updated in the ShoeShop table after the successful purchase for Rose, 11 - 1 = 10.
--The last UPDATE statement tries to buy Rose a pair of Trainers, but her balance becomes insufficient (Current balance of Rose: 100 < Price of Trainers: 300) after buying a pair of Boots. So, the last UPDATE statement fails. Since the whole transaction fails if any of the SQL statements fail, the transaction won't be committed.

--Practice exercise

--Create a stored procedure TRANSACTION_JAMES to execute a transaction based on the following scenario: First buy James 4 pairs of Trainers from ShoeShop. 
--Update his balance as well as the balance of ShoeShop. Also, update the stock of Trainers at ShoeShop. Then attempt to buy James a pair of Brogues from ShoeShop. If any of the UPDATE statements fail, the whole transaction fails. 
--You will roll back the transaction. Commit the transaction only if the whole transaction is successful.

DELIMITER //

CREATE PROCEDURE TRANSACTION_JAMES()

BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    UPDATE BankAccounts
    SET Balance = Balance-1200
    WHERE AccountName = 'James';

    UPDATE BankAccounts
    SET Balance = Balance+1200
    WHERE AccountName = 'Shoe Shop';

    UPDATE ShoeShop
    SET Stock = Stock-4
    WHERE Product = 'Trainers';

    UPDATE BankAccounts
    SET Balance = Balance-150
    WHERE AccountName = 'James';

    COMMIT;

END //

DELIMITER ; 


CALL TRANSACTION_JAMES;

SELECT * FROM BankAccounts;

SELECT * FROM ShoeShop;