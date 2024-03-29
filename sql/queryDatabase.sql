-- -----------------------------------------------------------------------------------------------------------------
-- i. Create an Employer.
-- -----------------------------------------------------------------------------------------------------------------
  
 SET @givenUserName = 'KevinCarlsen';
 SET @givenSubscriptionID = '3';
 SET @givenPassword = 'qetu';
 SET @givenEmail = 'kevin_carlsen@yahoo.com';
 SET @givenFirstName = 'Kevin';
 SET @givenLastName = 'Carlsen';
 SET @givenBalance = '0';
 SET @givenSuffering = '0';
 SET @givenActive = '1';
 SET @givenLastPayment = '2020-07-31'; 
  
INSERT INTO `User` (userName, `role`, subscriptionID, `password`, email, firstName, lastName, balance, suffering, `active`, lastPayment)
VALUES
(@givenUserName, 'employer', @givenSubscriptionID, @givenPassword, @givenEmail, @givenFirstName, @givenLastName,
@givenBalance, @givenSuffering, @givenActive, @givenLastPayment); 

-- -----------------------------------------------------------------------------------------------------------------
-- i. Delete an Employer.
-- -----------------------------------------------------------------------------------------------------------------

SET @givenUserName = 'AlexeiAdcocks';
SET @givenUserCreditCardNumber = 
	(SELECT C.creditCardNumber
    FROM creditCard AS C, paymentMethod AS P
    WHERE C.creditCardnumber = P.creditCardNumber AND P.userName = @givenUsername);
   
DELETE FROM paymentMethod 
WHERE 
	userName = @givenUserName; 

DELETE FROM creditcard
WHERE 
	creditCardNumber = @givenUserCreditCardNumber; 

DELETE FROM applicant 
WHERE jobID IN  
	(SELECT	A.jobID 
    FROM (SELECT * FROM job) AS J INNER JOIN (SELECT * FROM applicant) AS A
    WHERE J.userName = @givenUserName); 
    
DELETE FROM job 
WHERE 
	userName = @givenUserName; 
    
DELETE FROM `user`
WHERE 
	userName = @givenUserName;
 
-- -----------------------------------------------------------------------------------------------------------------
-- i. Display an Employer.
-- -----------------------------------------------------------------------------------------------------------------

 SET @givenUserName = 'AlexeiAdcocks';
 
 SELECT *
 FROM `user`
 where userName = @givenUserName;
 
-- -----------------------------------------------------------------------------------------------------------------
-- i. Edit an Employer.
-- -----------------------------------------------------------------------------------------------------------------
 
  SET @givenUserName = 'KevinCarlsen';
  
  SET @givenPassword = 'qetu';
  SET @givenEmail = 'Mickey_mouse@gg.com';
  SET @givenFirstName = 'Mickey';
  SET @givenLastName = 'Mouse';
  

UPDATE `user`
	SET `password` = @givenPassword, email = @givenEmail, firstName = @givenFirstName, lastName = @givenLastName
    WHERE userName = @givenUserName;

-- -----------------------------------------------------------------------------------------------------------------
-- ii. Create a category by an Employer.
-- -----------------------------------------------------------------------------------------------------------------
  SET @givenCategoryName = 'concordia';
  
  INSERT INTO category (categoryName)
  VALUES 
	(@givenCategoryName);
  
-- -----------------------------------------------------------------------------------------------------------------
-- ii. Delete a category by an Employer.
-- -----------------------------------------------------------------------------------------------------------------
  SET @givenCategoryName = 'concordia'; 
  
  DELETE FROM category
  WHERE 
	(categoryName = @givenCategoryName);
    
  -- -----------------------------------------------------------------------------------------------------------------
-- ii. Edit a category by an Employer.
-- -----------------------------------------------------------------------------------------------------------------  
  SET @originalCategoryName = 'concordia';
  SET @givenCategoryName = 'mcgill'; 
  
  UPDATE category
  SET categoryName = @givenCategoryName
  WHERE
		(categoryName = @originalCategoryName);
    
-- -----------------------------------------------------------------------------------------------------------------
-- ii. Display a category by an Employer.
-- -----------------------------------------------------------------------------------------------------------------     
    SET @givenCategoryName = 'mcgill';
   
    SELECT *
    FROM category
    where categoryName = @givenCategoryName; 
    
  
  -- -----------------------------------------------------------------------------------------------------------------
-- iii. post a new job by an employer 
-- ----------------------------------------------------------------------------------------------------------------- 
  
  SET @givenUserName = 'ArabellaAndreutti';
  SET @givenCategoryName = 'finance';
  SET @givenTitle = 'stock manager';
  SET @givenDatePosted = '2020-07-29';
  SET @givenDescription = 'we need a money maker';
  SET @givenEmployeesNeeded = '1';

INSERT INTO `job` (userName, categoryName, title, datePosted, `description`, employeesNeeded)
VALUES
	(@givenUserName, @givenCategoryName, @givenTitle, @givenDatePosted,	@givenDescription, @givenEmployeesNeeded);

-- ------------------------------------------------------------------------------------------------------------------
-- iv. Provide a job offer for an employee by an employer.
-- ------------------------------------------------------------------------------------------------------------------
SET @givenUserName = 'LeilaDisney';
SET @givenJobID = '1'; 

UPDATE applicant
SET status = 'offer'
WHERE userName = @givenUserName AND jobID = @givenJobID;

-- ------------------------------------------------------------------------------------------------------------------
-- v. Report of a posted job by an employer (Job title and description, date posted, 
-- list of employees applied to the job and status of each application).
-- ------------------------------------------------------------------------------------------------------------------
SET @givenJobID = '3';

SELECT J.title, J.`description`, J.datePosted, A.userName, A.`status`
FROM job as J INNER JOIN applicant as A
WHERE J.jobID = @givenJobID AND J.jobID = A.jobID;


-- ------------------------------------------------------------------------------------------------------------------
-- vi. Report of posted jobs by an employer during a specific period of time (Job title, date posted, 
-- short description of the job up to 50 characters, number of needed employees to the post, number of applied jobs to the post, 
-- number of accepted offers).
-- ------------------------------------------------------------------------------------------------------------------
SET @givenStartDate = '2020-02-01';
SET @givenEndDate = '2020-07-30';
SET @givenUserName = 'BabKelsall';

SELECT J.jobID, J.title, J.datePosted, J.`description`, J.employeesNeeded, count(A.jobID) as numOfApplicants
FROM job AS J, applicant AS A
WHERE J.datePosted BETWEEN @givenStartDate AND @givenEndDate 
		AND J.jobID = A.jobID 
        AND J.userName = @givenUserName
GROUP BY J.jobID;


-- -----------------------------------------------------------------------------------------------------------------
-- vii. Create an Employee.
-- -----------------------------------------------------------------------------------------------------------------
  
  SET @givenUserName = 'MickeyMouse';
  SET @givenSubscriptionID = '3';
  SET @givenPassword = 'qetu';
  SET @givenEmail = 'Mickey_mouse@gg.com';
  SET @givenFirstName = 'Mickey';
  SET @givenLastName = 'Mouse';
  SET @givenBalance = '0';
  SET @givenSuffering = '0';
  SET @givenActive = '1';
  SET @givenLastPayment = '2020-07-02'; 
  
INSERT INTO `user` (userName, `role`, subscriptionID, `password`, email, firstName, lastName, balance, suffering, `active`, lastPayment)
VALUES
(@givenUserName, 'employee', @givenSubscriptionID, @givenPassword, @givenEmail, @givenFirstName, @givenLastName,
@givenBalance, @givenSuffering, @givenActive, @givenLastPayment); 

-- -----------------------------------------------------------------------------------------------------------------
-- vii. Delete an Employee.
-- -----------------------------------------------------------------------------------------------------------------
SET @givenUserName = 'LeilaDisney';
SET @givenUserCreditCardNumber = 
	(SELECT C.creditCardNumber
    FROM creditCard AS C, paymentMethod AS P
    WHERE C.creditCardnumber = P.creditCardNumber AND P.userName = @givenUsername);

DELETE FROM paymentMethod 
WHERE 
	userName = @givenUserName; 

DELETE FROM creditcard
WHERE 
	creditCardNumber = @givenUserCreditCardNumber; 

DELETE FROM applicant 
WHERE 
	userName = @givenUserName; 
    
DELETE FROM `user`
WHERE 
	userName = @givenUserName;
 
-- -----------------------------------------------------------------------------------------------------------------
-- vii. Display an Employee.
-- -----------------------------------------------------------------------------------------------------------------
 SET @givenUserName = 'LeilaDisney';
 
 SELECT *
 FROM `user`
 where userName = @givenUserName;
 
-- -----------------------------------------------------------------------------------------------------------------
-- vii. Edit an Employee.
-- -----------------------------------------------------------------------------------------------------------------
  SET @givenUserName = 'MickeyMouse';
  
  SET @givenPassword = 'qetu';
  SET @givenEmail = 'MR_MICKEY@gg.com';
  SET @givenFirstName = 'TOM';
  SET @givenLastName = 'CAT';


UPDATE `user`
	SET `password` = @givenPassword, email = @givenEmail, firstName = @givenFirstName, lastName = @givenLastName
    WHERE userName = @givenUserName;

-- -----------------------------------------------------------------------------------------------------------------
-- viii. Search for a job by an Employee 
-- -----------------------------------------------------------------------------------------------------------------
SET @givenJobTitle = 'full stack developer';
SET @givenJobCategory = 'construction';

-- search by title 
SELECT *
FROM job 
WHERE title = @givenJobTitle; 

-- search by category 
SELECT *
FROM job
WHERE categoryName = @givenJobCategory; 

-- -----------------------------------------------------------------------------------------------------------------
-- ix. apply for a job by an employee
-- -----------------------------------------------------------------------------------------------------------------
SET @givenJobID = '5'; 
SET @givenUserName = 'LeilaDisney';

INSERT INTO applicant(userName, jobID, `status`) 
VALUES ( @givenUserName, @givenJobID,'pending');

-- -----------------------------------------------------------------------------------------------------------------
-- x. Accept a job offer by an employee 
-- -----------------------------------------------------------------------------------------------------------------
SET @givenJobID = '3';
SET @givenUserName = 'LeilaDisney';

UPDATE applicant 
SET `status` = 'hired'
WHERE
	jobID = @givenJobID AND
    userName = @givenUserName;

-- -----------------------------------------------------------------------------------------------------------------
-- xi. Withdraw from an applied job by an employee.
-- -----------------------------------------------------------------------------------------------------------------
SET @givenEmployeeUserName = 'JohnDoe';
SET @givenJobID = '1'; 

UPDATE Applicant
SET status = 'withdrawn'
WHERE
	userName = @givenEmployeeUserName AND
    jobID = @givenJobID;

-- ----------------------------------------------------------------------------------------------------------------  
-- xiii. Report of applied jobs by an employee during a specific period of time (Job title, date applied, short
-- description of the job up to 50 characters, status of the application).
-- ----------------------------------------------------------------------------------------------------------------    
SET @givenEmployeeUserName = 'LeilaDisney';
SET @givenStartDate = '2019-05-07';
SET @givenEndDate = '2020-06-07';

SELECT title, appliedDate, description, status
FROM Job, Applicant
WHERE
	Applicant.userName = @givenEmployeeUserName AND
    Job.jobID = Applicant.jobID AND
    @givenStartDate <= appliedDate AND
    appliedDate <= @givenEndDate;

-- ----------------------------------------------------------------------------------------------------------------  
-- xiv. Add a method of payment by a user.
-- ----------------------------------------------------------------------------------------------------------------

-- Add credit card.alter
SET @givenUserName = 'BabKelsall';
SET @givenCreditCardNumber = '3533824238000000';
SET @givenExpirationDate = '10/25';
SET @givenCvv = '123';

INSERT INTO `CreditCard` (creditCardNumber, expirationDate, cvv)
VALUES
	(@givenCreditCardNumber, @givenExpirationDate, @givenCvv);

INSERT INTO `PaymentMethod` (userName, creditCardNumber, accountNumber)
VALUES
	(@givenUserName, @givenCreditCardNumber , NULL);

-- Add bank accound.
SET @givenUserName = 'BabKelsall';
SET @givenAccountNumber = '1001000000';

INSERT INTO `PaymentMethod` (userName, creditCardNumber, accountNumber)
VALUES
	(@givenUserName, NULL, @givenAccountNumber);

-- ----------------------------------------------------------------------------------------------------------------  
-- xiv. Delete a method of payment by a user.
-- ----------------------------------------------------------------------------------------------------------------

SET @givenPaymentID = 30;

DELETE PaymentMethod, CreditCard
FROM PaymentMethod
	INNER JOIN CreditCard ON PaymentMethod.creditCardNumber = CreditCard.creditCardNumber
WHERE
	paymentID = @givenPaymentID;

DELETE FROM PaymentMethod
WHERE
	paymentID = @givenPaymentID;

-- ----------------------------------------------------------------------------------------------------------------  
-- xiv. Edit a method of payment by a user.
-- ----------------------------------------------------------------------------------------------------------------

-- Edit credit card.
SET @givenPaymentID = 3;
SET @givenCreditCardNumber = '3533824238000001';
SET @givenExpirationDate = '11/25';
SET @givenCvv = '123';

SET @previousCreditCardNumber = (SELECT creditCardNumber FROM PaymentMethod WHERE paymentID = @givenPaymentID);

UPDATE `CreditCard`
SET creditCardNumber = @givenCreditCardNumber, expirationDate = @givenExpirationDate, cvv = @givenCvv
WHERE
	creditCardNumber = @previousCreditCardNumber;

-- Edit bank account.
SET @givenPaymentID = 1;
SET @givenAccountNumber = '1001000001';

UPDATE `PaymentMethod`
SET accountNumber = @givenAccountNumber
WHERE
	paymentID = @givenPaymentID;

-- ----------------------------------------------------------------------------------------------------------------  
-- xvi. Make a manual payment by a user.
-- ----------------------------------------------------------------------------------------------------------------
SET @givenUserName = 'SanfordGout';

UPDATE User
SET balance = 0, lastPayment = DATE(NOW()), active = True
WHERE
	userName = @givenUserName AND
    subscriptionID <> 0;

-- ----------------------------------------------------------------------------------------------------------------  
-- xvii. Report of all users by the administrator for employers or employees (Name, email, category, status,
-- balance).
-- ----------------------------------------------------------------------------------------------------------------
SET @givenRole = 'employer';

SELECT firstName, lastName, email, Subscription.name, active, balance
FROM User, Subscription
WHERE
	User.subscriptionID = Subscription.subscriptionID AND
    role = @givenRole;


-- ----------------------------------------------------------------------------------------------------------------  
-- xviii. Report of all outstanding balance accounts (User name, email, balance, since when the account is
-- suffering).
-- ----------------------------------------------------------------------------------------------------------------
SELECT userName, email, balance, lastPayment
FROM User
WHERE
	balance < 0;
    
    
-- ----------------------------------------------------------------------------------------------------------------  
-- bonus: A suffering account will receive a warning message once a week until the account is settled or deactivated.
-- ----------------------------------------------------------------------------------------------------------------
SELECT userName, email 
FROM `user` 
WHERE lastPayment < DATE_ADD(DATE(NOW()), INTERVAL -1 WEEK)
		AND balance < 0 
        AND `active` = 1;


-- ----------------------------------------------------------------------------------------------------------------  
-- bonus: A suffering account for a year will be deactivated automatically by the system.
-- ----------------------------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES=0;
UPDATE `user`
	SET `active` = 0
    WHERE
		lastPayment < DATE_ADD(DATE(NOW()), INTERVAL -1 YEAR)
		AND balance < 0 
		AND `active` = 1;
SET SQL_SAFE_UPDATES=1;


-- ----------------------------------------------------------------------------------------------------------------  
-- bonus: Charge everyone using automatic payment in the DB the amount of their subscription cost. 
-- ----------------------------------------------------------------------------------------------------------------
SET SQL_SAFE_UPDATES=0;

-- for automatic payment 
UPDATE `user`
	SET lastPayment = DATE(NOW()), balance = 0
    WHERE paysWithManual = 0 
			AND `active` = 1 
            AND lastPayment < DATE_ADD(DATE(NOW()), INTERVAL -1 MONTH);

-- for manual payment 
SELECT userName, email 
	FROM `user`
    WHERE paysWithManual = 1 
			AND `active` = 1 
            AND lastPayment < DATE_ADD(DATE(NOW()), INTERVAL -1 MONTH); 

SET SQL_SAFE_UPDATES=1;
