db.getCollection('moviestarts').insertMany([
  {
    "title": "The Last Student Returns",
    "meta": { "rating": 9.5, "aired": 2018, "runtime": 100 },
    "visitors": 1300000,
    "expectedVisitors": 1550000,
    "genre": ["thriller", "drama", "action"]
  },
  {
      "title": "Supercharged Teaching",
      "meta": {"rating": 9.3, "aired": 2016, "runtime": 60},
      "visitors": 370000,
      "expectedVisitors": 1000000,
      "genre": ["thriller", "action"]
  },
  {
      "title": "Teach me if you can",
      "meta": {"rating": 8.5, "aired": 2014, "runtime": 90},
      "visitors": 590378,
      "expectedVisitors": 500000,
      "genre": ["action", "thriller"]
  }
]
)


// 1.	Display the first document
db.moviestarts.findOne({})

// 2.	Search all movies that have a rating higher than 9.2 and a runtime lower than 100 minutes
db.moviestarts.find({"meta.rating": {$gt : 9.2}, "meta.runtime": {$lt : 100}})


// 3.	Search all movies that have a genre of “drama” or “action”.
db.moviestarts.find({genre: { $in : ["drama", "action"]}})

// 4.	Search all movies that have a genre of “drama” and “action”. You must not use $and.
db.moviestarts.find({genre: { $all : ["drama", "action"]}})

// 5.	Search all movies where visitors exceeded expected visitors
db.moviestarts.find({$where : "this.visitors > this.expectedVisitors"})


// 6.	Search all movies that have a title contains the letter “Su”.
db.moviestarts.find({title : {$regex : ".*Su.*"}});


// 7.	Search all movies that either have a genre of “action” and “thriller” or have a genre of “drama”, and at the same time, have more than 300000 visitors with a rating between 8 and 9.5 (inclusive).
db.moviestarts.find({ '$or' : [ {genre: { $all : [ "action", "thriller"]}} , {genre: { $in : ["drama"]}}], visitors : {$gt : 300000}, "meta.rating": {$gte: 8, $lte: 9.5} })
