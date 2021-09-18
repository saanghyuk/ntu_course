// mongoimport --db nosql --collection restaurants --file restaurants.json


// 1.	Write a MongoDB query to display all the documents in the collection restaurants.

db.restaurants.find({})

//  2.	Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine for all the documents in the collection restaurant.
db.restaurants.find({ },{ restaurant_id: 1, borough: 1,cuisine: 1 , name : 1})


// 3.	Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine, but exclude the field _id for all the documents in the collection restaurant.
db.restaurants.find({ },{ address: 0, grades: 0, _id : 0 })


// 4.	Write a MongoDB query to display the fields restaurant_id, name, borough and zip code, but exclude the field _id for all
db.restaurants.find({ },{ restaurant_id: 1, name: 1,borough: 1, 'address.zipcode' : 1 ,  _id : 0})

db.restaurants.aggregate([
  {$project : {restaurant_id: 1, name: 1,borough: 1, zipcode : '$address.zipcode' ,  _id : 0 }}
])

// 5.	Write a MongoDB query to display all the restaurant which is in the borough Bronx. the documents in the collection restaurant.
db.restaurants.aggregate([
  {$match : {borough : 'Bronx'}}
])


// 6.	Write a MongoDB query to display the first 5 restaurant which is in the borough Bronx.
db.restaurants.aggregate([
  {$match : {borough : 'Bronx'}},
  {$limit : 5}
])


// 7.	Write a MongoDB query to display the next 5 restaurants after skipping first 5 which are in the borough Bronx.
db.restaurants.aggregate([
  {$match : {borough : 'Bronx'}},
  {$skip : 5}
])


// 8.	Write a MongoDB query to find the restaurants who achieved a score more than 90.
db.restaurants.aggregate([
  {$unwind : '$grades'},
  {$group : {
    _id : {_id : "$_id", name : "$name"},
    "score_sum": {$sum : "$grades.score"},
  }},
  {$match:
      {score_sum : {$gt : 80}}
      }
])


// 9.	Write a MongoDB query to find the restaurants that achieved a score, more than 80 but less than 100.
db.restaurants.aggregate([
  {$unwind : '$grades'},
  {$group : {
    _id : {_id : "$_id", name : "$name"},
    "score_sum": {$sum : "$grades.score"},
  }},
  {$match:
      {score_sum : {$gt : 80, $lt : 100}}
      }
])



// 10.	Write a MongoDB query to find the restaurants which locate in latitude value less than -95.754168.
db.restaurants.aggregate([
   { $addFields: { latitude: { $first: "$address.coord" } } },
   {$match : {latitude : {$lt : -95.754168}}},
   {$project : {latitude : 0}}
])

// 11.	Write a MongoDB query to find the restaurants that do not prepare any cuisine of 'American' and their grade score more than 70 and latitude less than -65.754168.

db.restaurants.aggregate([
  { $addFields: { latitude: { $first: "$address.coord" }} },
  {$unwind : '$grades'},
  {$group : {
    _id : {_id : "$_id", name : "$name", latitude : "$latitude", cuisine : "$cuisine"},
    "score_sum": {$sum : "$grades.score"},
  }},
  { $match : { '_id.cuisine' : { '$regex' :  "^((?!American).)*$" }, '_id.latitude': {$lt : -65.754168}, 'score_sum': {$gt : 70}}}
])


// 12.	Write a MongoDB query to find the restaurants which do not prepare any cuisine of 'American' and achieved a score more than 70 and located in the longitude less than -65.754168.
// Note : Do this query without using $and operator.

db.restaurants.aggregate([
  {$project: {
    "cuisine": 1,
    "longitude": {'$arrayElemAt': ['$address.coord', 1]},
    "score": {"$sum":"$grades.score"}
  }},
  { $match :{
      cuisine : { '$regex' :  "^((?!American).)*$" },
      longitude : {$lt : -65.754168},
      score : {$gt : 70}
    }
    }
])



// 13.	Write a MongoDB query to find the restaurants which do not prepare any cuisine of 'American ' and achieved a grade point 'A' not belongs to the borough Brooklyn. The document must be displayed according to the cuisine in descending order.
db.restaurants.aggregate([
  {$unwind : "$grades"},
  { $match :{
      cuisine : { '$regex' :  "^((?!American).)*$" },
      borough : { '$regex' :  "^((?!Brooklyn).)*$" },
      "grades.grade" : "A"}
    },
    {$group : {"_id": "$restaurant_id"}}
])


// 14.	Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'Wil' as first three letters for its name.
db.restaurants.aggregate([
  { $match :{
      name : { '$regex' :  "^Wil.*" }
    }},
    {$project : {address:0, _id:0, grades:0}}
])



// 15.	Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'ces' as last three letters for its name.
db.restaurants.aggregate([
  { $match :{
      name : { '$regex' :  ".*ces$" }
    }},
    {$project : {address:0, _id:0, grades:0}}
])



// 16.	Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'Reg' as three letters somewhere in its name.
db.restaurants.aggregate([
  { $match :{
      name : { '$regex' :  ".*Reg.*" }
    }},
    {$project : {address:0, _id:0, grades:0}}
])



// 17.	Write a MongoDB query to find the restaurants which belong to the borough Bronx and prepared either American or Chinese dish.
db.restaurants.aggregate([
  { $match :{
      cuisine : { '$regex' :  "American|Chinese" },
      borough : { '$regex' :  "Bronx" }}
    }
])



// 18.	Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which belong to the borough Staten Island or Queens or Bronxor Brooklyn.
db.restaurants.aggregate([
  { $match :{
      borough : { '$regex' :  "Staten Island|Queens|Bronxor Brooklyn" }}
    },
    {$project : {address:0, _id:0, grades:0}}
])



// 19.	Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which are not belonging to the borough Staten Island or Queens or Bronxor Brooklyn.
db.restaurants.aggregate([
  { $match :{
      borough : { '$regex' :  "^(?!.*(Staten Island|Queens|Bronxor Brooklyn)).*$" }}
    },
    {$project : {address:0, _id:0, grades:0}}
])



// 20.	Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which achieved a score which is not more than 10.

db.restaurants.aggregate([
  {$unwind : "$grades"},
  { $match :{
        "grades.score" : {$lte: 10}
  }},
  {$group : {
    _id : {_id : "$_id", name : "$name", borough : "$borough", restaurant_id : "$restaurant_id"}}}
])
