-- Part 1
-- Grouping the transactions of each cardholder
SELECT card_holder.name, sum(amount) as total_spent
FROM transaction 
LEFT JOIN credit_card
on transaction.card = credit_card.card
LEFT JOIN card_holder
on credit_card.cardholder_id = card_holder.id
GROUP BY card_holder.name;

-- Count the transactions that are less than $2.00 per cardholder.
SELECT card, count(amount) as tx_less_than_2
FROM transaction
WHERE amount < 2
GROUP BY card
ORDER BY tx_less_than_2 DESC;

-- Top 100 highest transactions made between 7:00 am and 9:00 am
SELECT date, amount
FROM transaction
WHERE EXTRACT(HOUR FROM date) BETWEEN '07' AND '08'
ORDER BY amount DESC LIMIT 100;

-- Number of fraudulent transactions grouped by hour
SELECT EXTRACT(HOUR FROM date) as hour, count(amount) as tx_less_than_2
FROM transaction
WHERE amount < 2
GROUP BY hour
ORDER BY tx_less_than_2 DESC;

-- Top 5 merchants prone to being hacked using small transactions
SELECT id_merchant, count(amount) as number_of_small_tx
FROM transaction
WHERE amount < 2
GROUP BY id_merchant
ORDER BY number_of_small_tx DESC
LIMIT 5;

-- Part 2
-- Loading data for card holder 2 and 18 from the database
SELECT transaction.amount, transaction.date, credit_card.cardholder_id
FROM transaction
LEFT JOIN credit_card 
ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id = 2 or credit_card.cardholder_id = 18;

-- Loading data of daily transactions from jan to jun 2018 for card holder 25
SELECT transaction.amount, transaction.date, credit_card.cardholder_id
FROM transaction
LEFT JOIN credit_card
ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id = 25
and date >= '2018-01-01 00:00:00' 
and date < '2018-07-01 00:00:00';