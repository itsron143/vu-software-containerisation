from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 
"postgresql://postgres:postgres@postgres:5432/people"
db = SQLAlchemy(app)
migrate = Migrate(app, db)


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


@app.route('/')
def hello():
    return {"hello": "world"}


if __name__ == '__main__':
    # init_db(app, db)
    app.run(debug=True, port=5001)
