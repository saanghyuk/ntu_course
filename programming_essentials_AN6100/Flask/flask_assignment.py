from flask import Flask
from flask_restful import Api, Resource, reqparse
import pymongo


# Connect to Mongo Server in the AWS EC2 INSTANCE
# "pip install pymongo" is required
conn = pymongo.MongoClient('#######IP_OF_DB#######', "PORT")
customer = conn.customer
customer_info = customer.info

app = Flask(__name__)
api = Api(app)


class Home(Resource):
    def get(self):
        return {'class_group': "B",
                'index_number': "31",
                "name": "SON SANG HYUK(NOEL)"
                }, 200


class CustomerAll(Resource):
    def get(self):
        infos = customer_info.find({})
        cus_dict = {}
        for i, info in enumerate(infos):
            del info["_id"]
            cus_dict[str(i+1)] = info
        return cus_dict


class CustomerSearch(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', required=True)
        args = parser.parse_args()
        infos = customer_info.find({"id": args["id"]})
        if infos.count():
            cus_dict = {}
            for i, info in enumerate(infos):
                del info["_id"]
                cus_dict[str(i + 1)] = info
            return cus_dict, 200
        else:
            return {"Message": "There is No Matching User the ID you typed"}, 200


class CustomerAdd(Resource):
    def get(self):
        parser = reqparse.RequestParser()
        parser.add_argument('id', required=True)
        parser.add_argument('name', required=True)
        args = parser.parse_args()

        new_object = customer_info.insert_one({
            "id": args["id"],
            "name": args["name"]
        })
        print(new_object)

        return {"Message": "Successfully Added to Database"}, 200


# Add URL endpoints
api.add_resource(Home, '/')
api.add_resource(CustomerAll, '/b/customer/all')
api.add_resource(CustomerSearch, '/b/customer')
api.add_resource(CustomerAdd, '/b/customer/add')

if __name__ == '__main__':
    app.run()
