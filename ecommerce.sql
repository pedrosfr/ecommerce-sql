use ecommerce;
show tables;

-- Quantos clientes estão cadastrados?
show tables;
select * from clients;
select count(*) as Total_clients from clients;

-- Quais clientes ainda não fizeram nenhum pedido?
select c.idClient, c.Fname, c.Lname from clients c 
left outer join orders o on c.idClient = o.idOrderClient 
where o.idOrderClient is null;

-- Quais clientes compraram produtos infantis (classification_kids = true)?
select DISTINCT c.idClient, Concat(Fname," ", Lname) as Clientes from clients c
inner join orders o on c.idClient = o.idOrderClient 
inner join productOrder po on o.idOrder = po.idPOorder
inner join product p on po.idPOproduct = p.idProduct
WHERE p.classification_kids = true;

-- Quantos pedidos foram realizados no total?
Select * from orders;
Select count(*) as Quantidade_Pedidos from orders;

-- Qual o valor total de frete arrecadado?
select sum(sendvalue) as Total_Frete from orders;

-- Qual o maior pedido (em quantidade total de itens)?
select o.idOrder, sum(poQuantity) as Total_Itens from orders o 
inner join productOrder po on o.idOrder = po.idPOorder 
group by o.idOrder
order by Total_Itens desc limit 1;

-- Quais produtos cada vendedor vende?
select * from productseller;
select s.idSeller, s.SocialName, sum(prodQuantity) from seller s 
inner join productseller ps on s.idSeller =  idPseller
group by s.idSeller, s.SocialName, prodQuantity;

-- Qual vendedor vendeu mais produtos no total?
select s.SocialName, sum(prodQuantity) as quantidade_vendidos from seller s
inner join productseller ps on s.idSeller = ps.idPseller 
group by s.SocialName
order by quantidade_vendidos desc limit 1;

-- Localização dos vendedores (quantos por cidade).
select location, count(location) from seller group by location; 

-- Quantos fornecedores existem?
select count(*) as Fornecedores from Supplier;

-- Quais fornecedores fornecem quais produtos?
select s.SocialName, p.Pname, ps.quantity from Supplier s 
inner join productSupplier ps on s.idSupplier = ps.idPsSupplier
inner join product p on p.idproduct = ps.idPsProduct
order by s.SocialName;

-- Algum produto é fornecido por mais de um fornecedor?
select p.Pname, Count(ps.idPsSupplier) as Total_Fornecedores from product p 
inner join productsupplier ps on p.idProduct = ps.idPsSupplier 
group by p.Pname
HAVING Count(ps.idPsSupplier) > 1;

-- Quantidade total de produto em estoque por localização
select * from product;
select * from productStorage;
select storageLocation, sum(quantity) from productStorage 
group by storageLocation;

-- Quais produtos estão armazenados em quais cidades?
select p.Pname, sl.location from product p 
inner join storagelocation sl on sl.idLproduct = p.idproduct;

-- Qual produto tem maior estoque?
select p.Pname, ps.quantity as Maior_Estoque from product p 
inner join productStorage ps on p.idProduct = ps.idProductStorage 
order by ps.quantity desc limit 1;