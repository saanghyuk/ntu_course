// import json
// mongoimport --db nosql --collection anz --jsonArray  --file anz.json


// 1)	How many transactions are performed by each customer_id?
db.anz.aggregate([
  {
      $group : {
          _id: "$customer_id",
          count: {$sum:1}
      }
  }
])

// 2)	Which state has customers with the highest average transaction amount?
// ACT
db.anz.aggregate([
  {$group : {_id : "$merchant_state", avg: {$avg: "$amount"}}},
  {$sort: {avg:-1}}
])



// 3)	Monthly transaction insights – for each month, generate the number of transactions made in each merchant_state.
db.anz.aggregate(
  [
    {
      $project:
         {
           merchant_state: 1,
           month: { $substr: [ "$extraction", 5, 2] }
         }
     },
     {$group : {_id:{month:"$month", merchant_state: "$merchant_state"}, count: {$sum: 1}}}
  ]
)


// 4)	Demographic and locational insights – For each merchant_state, generate the amount of unique male customers and female customers.

db.anz.aggregate(
  [
     { $group :
      {
        _id : {merchant_state:"$merchant_state", gender : "$gender"}, sum_amount : {$sum : "$amount"}
      }
    }
  ]
)
