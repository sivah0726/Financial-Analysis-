


SELECT * FROM Bank_loan_financial_data;


--Total Applications
SELECT COUNT(id) AS Total_Loan_Applications FROM Bank_loan_financial_data;

-- MTD(Month To Date) Loan Applications 
SELECT COUNT(id) AS Total_Applications FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


--MOM(Month Over Month) Loan Applications -> (MTD-PMTD)/PMTD          PMTD-> previous Month 
SELECT COUNT(id) AS PMTD_Total_Applications FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--TOTAL Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM Bank_loan_financial_data


--MTD 
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


--PMTD
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--Total Recieved Amount
SELECT SUM(total_payment) AS Total_Amount_Received FROM Bank_loan_financial_data


SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--AVerage Intrest Rate
SELECT AVG(int_rate) * 100 AS Average_Intrest_Rate FROM Bank_loan_financial_data			


SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_Avg_Intrest_Rate FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021


SELECT ROUND(AVG(int_rate),4) * 100 AS PMTD_Avg_Intrest_Rate FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021



--Average Debt-To-Income Ratio (DTI) 

SELECT ROUND(AVG(dti) , 4) * 100 AS Avg_DTI FROM Bank_loan_financial_data

SELECT ROUND(AVG(dti) , 4) * 100 AS MTD_Avg_DTI FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(dti) , 4) * 100 AS PMTD_Avg_DTI FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--Good Loan Application Percentage
SELECT(
	COUNT(CASE WHEN loan_status = 'Fully Paid' Or  loan_status = 'Current' 
	THEN id END ) * 100) / COUNT(id) AS Good_loan_Percentage
FROM Bank_loan_financial_data


-- Good Loan Applications
SELECT COUNT(id) AS  Good_Loan_Applications FROM Bank_loan_financial_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS  Good_Loan_Funded_Amount FROM Bank_loan_financial_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Received Amount
SELECT SUM(total_payment) AS  Good_Loan_Received_Amount FROM Bank_loan_financial_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


--Bad Loan Percentage
SELECT(
	COUNT(CASE WHEN loan_status = 'Charged Off' 
	THEN id END ) * 100.0) / COUNT(id) AS Bad_loan_Percentage
FROM Bank_loan_financial_data

-- Bad Loan Applications
SELECT COUNT(id) AS  Bad_Loan_Applications FROM Bank_loan_financial_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS  Bad_Loan_Funded_Amount FROM Bank_loan_financial_data
WHERE loan_status = 'Charged Off'

--Bad Loan Received Amount
SELECT SUM(total_payment) AS  Bad_Loan_Received_Amount FROM Bank_loan_financial_data
WHERE loan_status = 'Charged Off'



-- Loan Status Grid
SELECT 
	loan_status,
	COUNT(id) AS Total_Loan_Applications,
	SUM(total_payment) AS Total_Amount_Received,
	SUM(loan_amount) AS Total_Funded_Amount,
	AVG(int_rate * 100) AS Intrest_Rate,
	AVG(dti * 100 ) AS DTI
FROM 
	Bank_loan_financial_data
GROUP BY
	loan_status

--Monthly Trends By Issue Date
SELECT 
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_amount
FROM Bank_loan_financial_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status


SELECT 
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH,issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM Bank_loan_financial_data
GROUP BY MONTH(issue_date), DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)


--Regional Analysis
SELECT 
	address_state,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM Bank_loan_financial_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC


--Long Term Analysis
SELECT 
	term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM Bank_loan_financial_data
GROUP BY term
ORDER BY term


--Employee Lenghth Analysis
SELECT 
	emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM Bank_loan_financial_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC

--Bank Loan Purpose Breakdown
SELECT 
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM Bank_loan_financial_data
GROUP BY purpose
ORDER BY COUNT(id) DESC



--Home Ownership Analysis
SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM Bank_loan_financial_data
WHERE grade = 'A' AND address_state = 'CA'           
GROUP BY home_ownership

ORDER BY COUNT(id) DESC
