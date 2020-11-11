USE publications;

#Step1 Challenge 1:

SELECT ta.au_id, ta.title_id, round(t.advance * ta.royaltyper / 100) as advance, round(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles t, titleauthor ta, sales s;

#Step2 Challenge 1:

SELECT au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales_royalty FROM
(SELECT ta.au_id, ta.title_id, round(t.advance * ta.royaltyper / 100) as advance, round(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles t, titleauthor ta, sales s) step2_orders
GROUP BY au_id, title_id;

#Step 3 Challenge1:

SELECT au_id, (total_advance+total_sales_royalty) as profits FROM
(SELECT au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales_royalty FROM
(SELECT ta.au_id, ta.title_id, round(t.advance * ta.royaltyper / 100) as advance, round(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles t, titleauthor ta, sales s) step2_orders
GROUP BY au_id, title_id) step3_orders
ORDER BY profits DESC
limit 3;

#Step1 Challenge2:

SELECT ta.au_id, ta.title_id, round(t.advance * ta.royaltyper / 100) as advance, round(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles t, titleauthor ta, sales s;

#Step2 Challenge2:

CREATE TEMPORARY TABLE step2_orders
SELECT ta.au_id, ta.title_id, round(t.advance * ta.royaltyper / 100) as advance, round(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
FROM titles t, titleauthor ta, sales s;

SELECT au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales_royalty FROM
step2_orders
GROUP BY au_id, title_id;

#Step3 Challenge3:

CREATE TEMPORARY TABLE Step3_orders
SELECT au_id, title_id, sum(advance) as total_advance, sum(sales_royalty) as total_sales_royalty FROM
step2_orders
GROUP BY au_id, title_id;

SELECT au_id, (total_advance+total_sales_royalty) as profits FROM
step3_orders
ORDER BY profits DESC
limit 3;

#Challenge3:

DROP TABLE most_profiting_author;
CREATE TABLE most_profiting_author (SELECT au_id, (total_advance+total_sales_royalty) as profits FROM
step3_orders
ORDER BY profits DESC);

SELECT * FROM most_profiting_author;
