USE anz;

# 1)	How many unique accounts are there?
SELECT COUNT(DISTINCT(account)) FROM anz;

# 2)	What are the currencies used in transactions?
SELECT DISTINCT(currency) FROM anz;

#  3)	What are the types of txn_descriptions? For each type, how many transactions are there?
SELECT txn_description, COUNT(transaction_id) FROM anz
GROUP BY txn_description;

# 4)	Based on the above txn_descriptions types, for each type, how many unique accounts can be observed to have performed at least 2 transactions?

# first
SELECT txn_description, COUNT(DISTINCT(account))
FROM 
(
SELECT txn_description, account, COUNT(transaction_id) FROM anz
GROUP BY txn_description, account
HAVING COUNT(transaction_id) >= 2
) as count 
GROUP BY txn_description;


# second
(SELECT DISTINCT(txn_description), COUNT(account)
FROM
(
SELECT txn_description, account, COUNT(txn_description)
FROM anz
WHERE txn_description = 'SALES-POS'
GROUP BY account
HAVING COUNT(transaction_id) >= 2
) AS spos
GROUP BY txn_description)
UNION
(SELECT DISTINCT(txn_description), COUNT(account)
FROM
(
SELECT txn_description, account, COUNT(txn_description)
FROM anz
WHERE txn_description = 'POS'
GROUP BY account
HAVING COUNT(transaction_id) >= 2
) AS pos
GROUP BY txn_description);



# 5)	Are there any customers with more than one account? If so, how many?
SELECT COUNT(customer_id) 
FROM  (
SELECT customer_id, COUNT(account) FROM anz
GROUP BY customer_id
HAVING COUNT(account) > 1
) AS count_table;


# 6)	The management believes a majority of movements is “debit”, not “credit”. Is it the case?
# Only Debit is in the data
SELECT movement, COUNT(transaction_id) 
FROM anz 
GROUP BY movement;



# 7)	What are the top 3 most important merchants (i.e., merchants with the most transactions)?
SELECT merchant_id, COUNT(transaction_id) FROM anz
GROUP BY merchant_id
ORDER BY COUNT(transaction_id) DESC
LIMIT 3;


# 8) For each state, what are the top 3 most important merchants?
SELECT merchant_state, merchant_id, transaction_count
FROM
(
SELECT merchant_state, merchant_id, COUNT(transaction_id) AS transaction_count, 
ROW_NUMBER() OVER (PARTITION BY  merchant_state Order by COUNT(transaction_id) DESC) AS ranking
FROM anz
GROUP BY merchant_id, merchant_state
ORDER BY merchant_state, COUNT(transaction_id) DESC
) AS merchant_table
WHERE ranking <= 3;



# 9)	For each state, what is the total amount of transactions? 
SELECT merchant_state, SUM(amount) FROM anz
GROUP BY merchant_state;


# 10)	Related to (3), does all merchants utilized all the available forms of transactions? Provide details.
# Only 777 merchants among 5725 utiized all available forms of transactions
SELECT COUNT(count_number)
FROM
(SELECT merchant_id, txn_description,
ROW_NUMBER() OVER (PARTITION BY  merchant_id Order by txn_description) AS count_number
FROM anz
GROUP BY merchant_id, txn_description
ORDER BY merchant_id
) AS count_table
WHERE count_number = 2; 
;

SELECT COUNT(DISTINCT(merchant_id)) FROM anz;


