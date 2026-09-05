USE vendor_performance_analysis;
SHOW TABLES;
CREATE TABLE begin_inventory (
    InventoryId VARCHAR(50),
    Store INT,
    City VARCHAR(100),
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    onHand INT,
    Price DECIMAL(10,2),
    startDate DATE
);
SELECT COUNT(*) AS total_rows
FROM begin_inventory;

USE vendor_performance_analysis;

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    InventoryId VARCHAR(50),
    Store INT,
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    SalesQuantity INT,
    SalesDollars DECIMAL(12,2),
    SalesPrice DECIMAL(10,2),
    SalesDate DATE,
    Volume VARCHAR(50),
    Classification INT,
    ExciseTax DECIMAL(12,2),
    VendorName VARCHAR(255),
    VendorNumber INT
);

DESCRIBE sales;
SELECT COUNT(*) AS total_rows
FROM sales;
SHOW VARIABLES LIKE 'secure_file_priv';

USE vendor_performance_analysis;

DROP TABLE IF EXISTS end_inventory;

CREATE TABLE end_inventory (
    InventoryId VARCHAR(50),
    Store INT,
    City VARCHAR(100),
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    onHand INT,
    Price DECIMAL(10,2),
    endDate DATE
);

SELECT COUNT(*) AS total_rows
FROM end_inventory;

SELECT COUNT(*) AS total_rows
FROM sales;

TRUNCATE TABLE sales;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_clean.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SELECT COUNT(*) AS total_rows
FROM sales;
SELECT COUNT(*) AS total_rows
FROM begin_inventory;
SELECT COUNT(*) AS total_rows
FROM end_inventory;
SELECT COUNT(*) AS total_rows
FROM purchase_prices;

USE vendor_performance_analysis;

DROP TABLE IF EXISTS purchases;

CREATE TABLE purchases (
    InventoryId VARCHAR(50),
    Store INT,
    Brand INT,
    Description VARCHAR(255),
    Size VARCHAR(50),
    VendorNumber INT,
    VendorName VARCHAR(255),
    PONumber INT,
    PODate DATE,
    ReceivingDate DATE,
    InvoiceDate DATE,
    PayDate DATE,
    PurchasePrice DECIMAL(10,2),
    Quantity INT,
    Dollars DECIMAL(12,2),
    Classification INT
);

SELECT COUNT(*) AS total_rows
FROM purchases;

LOAD DATA LOCAL INFILE
'G:/vendor performance analysis/Notebook/purchases_clean.csv'
INTO TABLE purchases
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/purchases_clean.csv'
INTO TABLE purchases
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

ALTER TABLE purchases
ADD COLUMN ReceivingDays INT,
ADD COLUMN InvoiceDays INT,
ADD COLUMN PaymentDays INT;

DESCRIBE purchases;

SELECT COUNT(*) AS total_rows
FROM purchases;

SELECT *
FROM purchases
LIMIT 5;







#Vendor_Analysis
USE vendor_performance_analysis;
SELECT DATABASE();
SHOW TABLES;

SELECT *
FROM sales
LIMIT 5;

SELECT
    VendorNumber,
    SalesDollars
FROM sales
LIMIT 10;

SELECT SUM(SalesDollars)
FROM sales;

SELECT SUM(PurchasePrice)
FROM purchase_prices;

SELECT
    VendorNumber,
    SUM(PurchasePrice)
FROM purchase_prices
GROUP BY VendorNumber;

SELECT
    VendorNumber,
    SUM(PurchasePrice) AS TotalPurchasePrice
FROM purchase_prices
GROUP BY VendorNumber
ORDER BY TotalPurchasePrice DESC;

SELECT
    VendorNumber,
    VendorName,
    SUM(Dollars) AS TotalPurchaseDollars
FROM purchases
GROUP BY
    VendorNumber,
    VendorName
ORDER BY
    TotalPurchaseDollars DESC
LIMIT 10;

SELECT
    VendorNumber,
    VendorName,
    SUM(SalesDollars) AS TotalSalesDollars
FROM sales
GROUP BY
    VendorNumber,
    VendorName
ORDER BY
    TotalSalesDollars DESC;
    
    
#CREATING_VENDOR_PERFORMANCE_TABLE
  
  DROP TABLE IF EXISTS vendor_performance;

CREATE TABLE vendor_performance AS

SELECT
    s.VendorNumber,
    MAX(s.VendorName) AS VendorName,
    s.TotalSalesDollars,
    p.TotalPurchaseDollars,
    s.TotalSalesDollars - p.TotalPurchaseDollars AS GrossProfit,
    ROUND(
        (s.TotalSalesDollars - p.TotalPurchaseDollars)
        / NULLIF(s.TotalSalesDollars, 0) * 100,
        2
    ) AS ProfitMargin
FROM
    (
        SELECT
            VendorNumber,
            MAX(VendorName) AS VendorName,
            SUM(SalesDollars) AS TotalSalesDollars
        FROM sales
        GROUP BY VendorNumber
    ) s
JOIN
    (
        SELECT
            VendorNumber,
            SUM(Dollars) AS TotalPurchaseDollars
        FROM purchases
        GROUP BY VendorNumber
    ) p
ON s.VendorNumber = p.VendorNumber
GROUP BY
    s.VendorNumber,
    s.TotalSalesDollars,
    p.TotalPurchaseDollars;
    
    
SELECT *
FROM vendor_performance
ORDER BY GrossProfit DESC;

SELECT *
FROM vendor_performance
ORDER BY TotalSalesDollars DESC
LIMIT 10;

SELECT *
FROM vendor_performance
ORDER BY GrossProfit DESC
LIMIT 10;

SELECT *
FROM vendor_performance
ORDER BY ProfitMargin DESC
LIMIT 10;


#ANALYSIS_PRODUCT_PERFORMANCE
SELECT
    Description,
    SUM(SalesDollars) AS TotalRevenue
FROM sales
GROUP BY Description
ORDER BY TotalRevenue DESC
LIMIT 10;


DESCRIBE sales;
DESCRIBE purchases;


SELECT
    s.Brand,
    s.Description,
    s.TotalSalesDollars,
    p.TotalPurchaseDollars,
    s.TotalSalesDollars - p.TotalPurchaseDollars AS GrossProfit
FROM
    (
        SELECT
            Brand,
            Description,
            SUM(SalesDollars) AS TotalSalesDollars
        FROM sales
        GROUP BY Brand, Description
    ) s
JOIN
    (
        SELECT
            Brand,
            Description,
            SUM(Dollars) AS TotalPurchaseDollars
        FROM purchases
        GROUP BY Brand, Description
    ) p
ON s.Brand = p.Brand
AND s.Description = p.Description
ORDER BY GrossProfit DESC
LIMIT 10;

SELECT
    s.Brand,
    s.Description,
    s.TotalSalesDollars,
    p.TotalPurchaseDollars,
    s.TotalSalesDollars - p.TotalPurchaseDollars AS GrossProfit,
    ROUND(
        (s.TotalSalesDollars - p.TotalPurchaseDollars)
        / s.TotalSalesDollars * 100,
        2
    ) AS ProfitMargin
FROM
    (
        SELECT
            Brand,
            Description,
            SUM(SalesDollars) AS TotalSalesDollars
        FROM sales
        GROUP BY Brand, Description
    ) s
JOIN
    (
        SELECT
            Brand,
            Description,
            SUM(Dollars) AS TotalPurchaseDollars
        FROM purchases
        GROUP BY Brand, Description
    ) p
ON s.Brand = p.Brand
AND s.Description = p.Description
WHERE s.TotalSalesDollars > 0
ORDER BY ProfitMargin ASC
LIMIT 10;

#CREATING_PRODUCT_PERFORMANCE_TABLE

CREATE TABLE product_performance AS
SELECT
    s.Brand,
    s.Description,
    s.TotalSalesDollars,
    p.TotalPurchaseDollars,

    s.TotalSalesDollars - p.TotalPurchaseDollars AS GrossProfit,

    CAST(
        CASE
            WHEN s.TotalSalesDollars = 0 THEN 0
            ELSE
                ((s.TotalSalesDollars - p.TotalPurchaseDollars)
                / s.TotalSalesDollars) * 100
        END
        AS DECIMAL(10,2)
    ) AS ProfitMargin

FROM (
    SELECT
        Brand,
        Description,
        SUM(SalesDollars) AS TotalSalesDollars
    FROM sales
    GROUP BY Brand, Description
) s

JOIN (
    SELECT
        Brand,
        Description,
        SUM(Dollars) AS TotalPurchaseDollars
    FROM purchases
    GROUP BY Brand, Description
) p

ON s.Brand = p.Brand
AND s.Description = p.Description;

DESCRIBE product_performance;

SELECT
    MIN(ProfitMargin) AS MinProfitMargin,
    MAX(ProfitMargin) AS MaxProfitMargin,
    AVG(ProfitMargin) AS AvgProfitMargin
FROM product_performance;

SELECT
    Brand,
    Description,
    TotalSalesDollars,
    TotalPurchaseDollars,
    GrossProfit,
    ProfitMargin
FROM product_performance
ORDER BY ProfitMargin ASC
LIMIT 10;

SELECT
    COUNT(*) AS LossMakingProducts
FROM product_performance
WHERE GrossProfit < 0;

SELECT
    COUNT(*) AS TotalProducts,
    SUM(CASE WHEN GrossProfit < 0 THEN 1 ELSE 0 END) AS LossMakingProducts,
    SUM(CASE WHEN GrossProfit >= 0 THEN 1 ELSE 0 END) AS ProfitableProducts
FROM product_performance;

SELECT
    Brand,
    Description,
    SUM(SalesQuantity) AS TotalSalesQuantity,
    SUM(SalesDollars) AS TotalSalesDollars
FROM sales
WHERE Brand = 27342
  AND Description = '19 Crimes The Banished Red'
GROUP BY Brand, Description;

SELECT
    Brand,
    Description,
    SUM(Quantity) AS TotalPurchaseQuantity,
    SUM(Dollars) AS TotalPurchaseDollars
FROM purchases
WHERE Brand = 27342
  AND Description = '19 Crimes The Banished Red'
GROUP BY Brand, Description;

SELECT
    Brand,
    Description,
    PurchasePrice
FROM purchase_prices
WHERE Brand = 27342;

#CREATING_NEW_PRODUCT_TABLE

DROP TABLE IF EXISTS product_performance;

CREATE TABLE product_performance AS
SELECT
    s.Brand,
    MAX(s.Description) AS Description,

    SUM(s.SalesDollars) AS TotalSalesDollars,

    SUM(s.SalesQuantity * p.PurchasePrice) AS TotalPurchaseDollars,

    SUM(s.SalesDollars)
        - SUM(s.SalesQuantity * p.PurchasePrice) AS GrossProfit,

    (
        (
            SUM(s.SalesDollars)
            - SUM(s.SalesQuantity * p.PurchasePrice)
        )
        / NULLIF(SUM(s.SalesDollars), 0)
    ) * 100 AS ProfitMargin

FROM sales s

JOIN purchase_prices p
    ON s.Brand = p.Brand

GROUP BY
    s.Brand;
    
SELECT *
FROM product_performance
WHERE Brand = 27342;


#INVENTORY_ANALYSIS

SELECT *
FROM begin_inventory
LIMIT 10;

SELECT *
FROM end_inventory
LIMIT 10;
#CALCULATING_BEG_AND_END_INV_VAL

SELECT
    SUM(onHand * Price) AS TotalBeginningInventoryValue
FROM begin_inventory;

SELECT
    SUM(onHand * Price) AS TotalEndingInventoryValue
FROM end_inventory;

SELECT
    SUM(Dollars) AS TotalPurchases
FROM purchases;

SELECT
    Brand,
    Description,
    SUM(onHand * Price) AS BeginningInventoryValue
FROM begin_inventory
GROUP BY Brand, Description
ORDER BY BeginningInventoryValue DESC
LIMIT 10;

SELECT
    Brand,
    Description,
    SUM(onHand * Price) AS EndingInventoryValue
FROM end_inventory
GROUP BY Brand, Description
ORDER BY EndingInventoryValue DESC
LIMIT 10;

SELECT
    Brand,
    Description,
    SUM(Dollars) AS PurchaseValue
FROM purchases
GROUP BY Brand, Description
ORDER BY PurchaseValue DESC
LIMIT 10;

#CALCULATING_COGS

SELECT
    b.Brand,
    b.Description,
    b.BeginningInventoryValue,
    p.PurchaseValue,
    e.EndingInventoryValue,

    b.BeginningInventoryValue
        + p.PurchaseValue
        - e.EndingInventoryValue AS COGS

FROM
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS BeginningInventoryValue
    FROM begin_inventory
    GROUP BY Brand, Description
) b

JOIN
(
    SELECT
        Brand,
        Description,
        SUM(Dollars) AS PurchaseValue
    FROM purchases
    GROUP BY Brand, Description
) p
ON b.Brand = p.Brand
AND b.Description = p.Description

JOIN
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS EndingInventoryValue
    FROM end_inventory
    GROUP BY Brand, Description
) e
ON b.Brand = e.Brand
AND b.Description = e.Description

ORDER BY COGS DESC
LIMIT 10;

#CALCULATING_INVENTORY_CHANGE
SELECT
    b.Brand,
    b.Description,
    b.BeginningInventoryValue,
    e.EndingInventoryValue,
    e.EndingInventoryValue - b.BeginningInventoryValue AS InventoryChange
FROM
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS BeginningInventoryValue
    FROM begin_inventory
    GROUP BY Brand, Description
) b
JOIN
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS EndingInventoryValue
    FROM end_inventory
    GROUP BY Brand, Description
) e
ON b.Brand = e.Brand
AND b.Description = e.Description
ORDER BY InventoryChange DESC
LIMIT 10;

#CALCULATING_AVERAGE_INVENTORY

SELECT
    b.Brand,
    b.Description,
    b.BeginningInventoryValue,
    e.EndingInventoryValue,
    
    (b.BeginningInventoryValue + e.EndingInventoryValue) / 2
        AS AverageInventory

FROM
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS BeginningInventoryValue
    FROM begin_inventory
    GROUP BY Brand, Description
) b

JOIN
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS EndingInventoryValue
    FROM end_inventory
    GROUP BY Brand, Description
) e
ON b.Brand = e.Brand
AND b.Description = e.Description

ORDER BY AverageInventory DESC
LIMIT 10;

#CALCULATING_INVENTORY TURNOVER
SELECT
    b.Brand,
    b.Description,
    b.BeginningInventoryValue,
    e.EndingInventoryValue,

    (b.BeginningInventoryValue + e.EndingInventoryValue) / 2
        AS AverageInventory,

    (b.BeginningInventoryValue
        + p.PurchaseValue
        - e.EndingInventoryValue) AS COGS,

    (b.BeginningInventoryValue
        + p.PurchaseValue
        - e.EndingInventoryValue)
        /
    NULLIF(
        (b.BeginningInventoryValue + e.EndingInventoryValue) / 2,
        0
    ) AS InventoryTurnover

FROM
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS BeginningInventoryValue
    FROM begin_inventory
    GROUP BY Brand, Description
) b

JOIN
(
    SELECT
        Brand,
        Description,
        SUM(Dollars) AS PurchaseValue
    FROM purchases
    GROUP BY Brand, Description
) p
ON b.Brand = p.Brand
AND b.Description = p.Description

JOIN
(
    SELECT
        Brand,
        Description,
        SUM(onHand * Price) AS EndingInventoryValue
    FROM end_inventory
    GROUP BY Brand, Description
) e
ON b.Brand = e.Brand
AND b.Description = e.Description

ORDER BY InventoryTurnover ASC
LIMIT 10;

DESCRIBE purchases;























































