/* consulta que permita conocer cuál es el producto que más stock tiene.*/

SELECT name,stock FROM `create_product` WHERE stock=(select max(stock) from create_product)

/*consulta que permita conocer cuál es el producto más vendido.*/

SELECT CP.name FROM create_product CP INNER JOIN sell_product SP ON CP.product_id=SP.sell_product_id WHERE SP.sell_product_howmany=(select max(sell_product_howmany) from sell_product)

