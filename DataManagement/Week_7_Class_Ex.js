// Part 1

db.getCollection('boxofficeExtended').insertMany([
  {
    "title": "The Last Student Returns",
    "meta": { "rating": 9.5, "aired": 2018, "runtime": 100 },
    "visitors": 1300000,
    "expectedVisitors": 1550000,
    "genre": ["thriller", "drama", "action"],
    "ratings": [
      10,
      9
    ]
  },
  {
      "title": "Supercharged Teaching",
      "meta": {"rating": 9.3, "aired": 2016, "runtime": 60},
      "visitors": 370000,
      "expectedVisitors": 1000000,
      "genre": ["thriller", "action"],
      "ratings": [
        10,
        9,
        9
      ]
  },
  {
      "title": "Teach me if you can",
      "meta": {"rating": 8, "aired": 2014, "runtime": 90},
      "visitors": 590378,
      "expectedVisitors": 500000,
      "genre": ["action", "thriller"],
      "ratings": [
        8,
        8
      ]
  }
])


// 1.	Find all movies with exactly two genres.
db.boxofficeExtended.find({genre : {$size : 2}})

// 2.Find all movies which aired in 2018.
db.boxofficeExtended.find({"meta.aired" : 2014})

// 3.	Find all movies which have ratings greater than 8 but lower than 10.
db.boxofficeExtended.find({ratings : {$in : [9]}})




// Part 2
// 1.	Insert the following documents using upsert, not insert( ).
db.teams.updateMany({"title" : "Nanyang United"},
  {$set : {"requiresTeam" : true}}, {upsert:true}
)

db.teams.updateMany({"title" : "Sengkang One"},
  {$set : {"requiresTeam" : false}}, {upsert:true}
)

// 2.	Update all documents which do require a team by adding a new field with the minimum amount of players required.
db.teams.updateMany({"requiresTeam" : true},
  {$set : {"minPlayers" : 5}}
)

// 3.	Update all documents that require a team by increasing the number of required players by 10.
db.teams.updateMany({"requiresTeam" : true},
  {$set : {"minPlayers" : 10}}
)
