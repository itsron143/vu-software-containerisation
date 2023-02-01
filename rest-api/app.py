import os

from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS, cross_origin
from dotenv import load_dotenv

app = Flask(__name__)

load_dotenv()

app.config['SECRET_KEY'] = 'secret-key-goes-here'
app.config['CORS_HEADERS'] = 'Content-Type'

cors = CORS(app, resources={r"/people": {"origins": "http://localhost:port"}})

POSTGRES_USERNAME = os.getenv('POSTGRES_USER', 'postgres')
POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'postgres')
POSTGRES_DB = os.getenv('POSTGRES_DB', 'people')

print(POSTGRES_USERNAME, POSTGRES_PASSWORD, POSTGRES_DB)

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://{}:{}@postgres:5432/{}'.format(
        POSTGRES_USERNAME, POSTGRES_PASSWORD, POSTGRES_DB)
db = SQLAlchemy(app)

class PeopleModel(db.Model):
    __tablename__ = 'people'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String())
    age = db.Column(db.Integer())

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"<Human {self.name}>"


@app.route('/people', methods=['POST', 'GET'])
@cross_origin(origin='localhost',headers=['Content- Type','Authorization'])
def handle_people():
    if request.method == 'POST':
        if request.is_json:
            data = request.get_json()
            new_human = PeopleModel(name=data['name'], age=data['age'])
            db.session.add(new_human)
            db.session.commit()
            return {"message": f"Human {new_human.name} has been created successfully."}
        else:
            return {"error": "The request payload is not in JSON format"}

    elif request.method == 'GET':
        people = PeopleModel.query.all()
        results = [
            {
                "name": human.name,
                "age": human.age
            } for human in people]

        return {"count": len(results), "humans": results}

def init_db(app, db):
    with app.app_context():
        # create tables
        db.drop_all()
        db.create_all()
        db.session.commit()
        print("Created table: People!")

@app.route('/')
def hello():
    return {"hello": "world"}


if __name__ == '__main__':
    init_db(app, db)
    app.run(debug=True, port=5001)
