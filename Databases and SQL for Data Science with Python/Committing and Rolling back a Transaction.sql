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
--Bu kýsým, SQLEXCEPTION hatasý oluþmasý durumunda çalýþtýrýlacak hata iþleyicisini tanýmlamaktadýr. Hata iþleyicisi, öncelikle yapýlan tüm deðiþiklikleri geri alýr (rollback), ardýndan hatayý yeniden yayar (resignal). Hatayý yeniden yaymak, hatanýn prosedürü çaðýran koda iletilmesini saðlar.
--Bu kod, Rose'un banka hesabýndan Ayakkabý Maðazasý'nýn banka hesabýna para transfer eden ve Ayakkabý Maðazasý'ndaki bot stokunu güncelleyen bir SQL stored procedure'üdür.

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

--Adým adým açýklama:
--CREATE PROCEDURE TRANSACTION_ROSE() Bu ifade, TRANSACTION_ROSE() adlý bir stored procedure oluþturur. Stored procedure'ler, tek bir ifadeyle yürütülebilen yeniden kullanýlabilir SQL kod bloklarýdýr. BEGIN Bu ifade, stored procedure gövdesinin baþlangýcýný iþaret eder. DECLARE EXIT HANDLER FOR SQLEXCEPTION Bu ifade, SQLEXCEPTION sýnýfý için bir istisna iþleticisi tanýmlar. Bu, stored procedure yürütülürken herhangi bir SQL hatasý oluþursa, istisna iþleticisi içindeki kodun yürütüleceði anlamýna gelir. ROLLBACK Bu ifade, iþlem baþladýðýndan beri veritabanýna yapýlan tüm deðiþiklikleri geri alýr. RESIGNAL Bu ifade, istisnayý yeniden yükseltir, böylece çaðrýyan kod onu iþleyebilir. START TRANSACTION Bu ifade, yeni bir veritabaný iþlemi baþlatýr. Bir iþlem, tek bir birim olarak ele alýnan bir grup veritabaný iþlemidir. Ýþlem sýrasýnda veritabanýna yapýlan tüm deðiþiklikler, iþlemin sonunda ya kaydedilir ya da geri alýnýr.  COMMIT Bu ifade, iþlemi onaylar, veritabanýna yapýlan tüm deðiþiklikleri kalýcý hale getirir. END Bu ifade, stored procedure gövdesinin sonunu iþaret eder. DELIMITER ; Bu ifade, ayýrýcýyý tekrar noktalý virgül karakterine ayarlar.

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