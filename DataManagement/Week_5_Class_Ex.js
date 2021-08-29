

/////////SIMPLE CLININC///////////

// 1 Create the above database and collection.
use simpleClinic

// 2. Insert the above document into the collection.
db.patients.insertOne({
  firstName : "Ben",
  lastName : "Choi",
  age : 18,
  history:[
    {disease : "cold", treatment : "pain killer"},
    {checkup : "annual", output : "OK"},
    {disease : "sore throat", treatment : "antibodies"}
  ]
})


// 3.	Insert 3 additional patient records (documents) with at least 1 history entry per patient.
db.patients.insertOne({
  firstName : "Noel",
  lastName : "Son",
  age : 20,
  history:[
    {disease : "COVID-19", treatment : "pain killer"},
    {checkup : "annual", output : "OK"}
  ]
})

db.patients.insertOne({
  firstName : "Li",
  lastName : "Zizheng",
  age : 23,
  history:[
    {disease : "flu", treatment : "antibodies"}
  ]
})

db.patients.insertOne({
  firstName : "Liben",
  lastName : "Yaun",
  age : 32,
  history:[
    {checkup : "annual", output : "OK"},
    {disease : "cold", treatment : "pain killer"},
    {disease : "sore throat", treatment : "antibodies"}
  ]
})

db.patients.insertOne({
  firstName : "SON",
  lastName : "SANG HYUK",
  age : 23,
  history:[
    {disease : "flu", treatment : "antibodies"},
    {disease : "sore throat", treatment : "antibodies"}
  ]
})
// 4.	Test out your database with find().
db.patients.find()

// 5.	Find all patients who are older than 30 years old (or a value of your choice).

db.patients.find({'age' : {'$gte' : 27 }})

// 6. Delete all patients who got a flu as a disease.
db.patients.deleteMany({'history.disease' : 'flu'})




////////AMAZON PRIME///////////////
// 1.	Create a MongoDB to capture the above records (database name = amazonPrime). You can use a maximum of 3 collections.
// 2.	Insert the records in the above tables into documents in each collection.
// You must observe the relationships depicted in the ERD, either by reference or embedded documents.

use amazonPrime


db.Customer.insertMany([
    {CustomerID : 1000, Name : "Ben Choi"},
    {CustomerID : 1001, Name : "Jayden Choi"},
    {CustomerID : 1002, Name : "Cammy Soh"},
    {CustomerID : 1004, Name : "Mason Greenwood"},
    {CustomerID : 1005, Name : "Dean Henderson"}
])


db.Product.insertMany([
    {ProductID : 50001, ProductName : "Scott Pick A Size Multi Purpose Towels", Price: 4.25},
    {ProductID : 50002, ProductName : "Japanese Super Crispy Chicken", Price: 11.80},
    {ProductID : 50003, ProductName : "Vegan Beyond Burger Plant Based Patties Beef", Price: 14.90},
    {ProductID : 50004, ProductName : "Korean Honey Sweet Potato", Price: 9.90 },
    {ProductID : 50005, ProductName : "Premium Atlantic Salmon 1Kg", Price: 22.00},
])



db.OrderDetail.insertMany([
      {OrderID : 1880001, CustomerID : 1000, OrderDate : "2020/01/21", OrderDetails:[
                {ProductID : 50001, Quantity: 2},
                {ProductID : 50003, Quantity: 1}]},
      {OrderID : 1880002, CustomerID : 1000, OrderDate : "2020/01/22", OrderDetails:[
              {ProductID : 50002, Quantity: 2}]},
      {OrderID : 1880003, CustomerID : 1000, OrderDate : "2020/01/23", OrderDetails:[
            {ProductID : 50004, Quantity: 4},
            {ProductID : 50005, Quantity: 2}]},
      {OrderID : 1880004, CustomerID : 1001, OrderDate : "2020/01/22", OrderDetails:[
          {ProductID : 50003, Quantity: 1},
          {ProductID : 50004, Quantity: 1}]},
      {OrderID : 1880005, CustomerID : 1001, OrderDate : "2020/01/23", OrderDetails:[
        {ProductID : 50002, Quantity: 2}]},
      {OrderID : 1880006, CustomerID : 1004, OrderDate : "2020/01/24", OrderDetails:[
      {ProductID : 50004, Quantity: 1},
      {ProductID : 50005, Quantity: 1}]},
    {OrderID : 1880007, CustomerID : 1005, OrderDate : "2020/01/25", OrderDetails:[
      {ProductID : 50002, Quantity: 2},
      {ProductID : 50003, Quantity: 1},
      {ProductID : 50001, Quantity: 2}]}
])

// change the types to INT
db.OrderDetail.find().forEach(function(item) {
  item.OrderID = new NumberInt(item.OrderID);
  item.CustomerID = new NumberInt(item.CustomerID);
  item.OrderDetails.forEach(function(item2){
    item2.ProductID = new NumberInt(item.ProductID);
    item2.Quantity = new NumberInt(item.Quantity)})
  db.OrderDetail.save(item);
  })




  // 3.	Give a brief justification on your data model in a word document.
  // Customer and Product documents have same properties with ERD.
  // However, I've combined Order and OrderLine documents because these two have similar structure, information, and d uplicate properties.
  // In OrderDetail document, it contains the information from Order document in outer layer and has related information from OrderLine document in embeded layer.