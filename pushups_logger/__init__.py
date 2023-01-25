import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy_utils import create_database, database_exists
from flask_login import LoginManager

from dotenv import load_dotenv

# init SQLAlchemy so we can use it later in our models
db = SQLAlchemy()


def create_app():
    app = Flask(__name__)

    load_dotenv()

    app.config['SECRET_KEY'] = 'secret-key-goes-here'

    POSTGRES_USERNAME = os.getenv('POSTGRES_USER')
    POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD')
    POSTGRES_DB = os.getenv('POSTGRES_DB')

    app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://{}:{}@postgres:5432/{}'.format(
        POSTGRES_USERNAME, POSTGRES_PASSWORD, POSTGRES_DB)

    # db_url = app.config['SQLALCHEMY_DATABASE_URI']

    # if not database_exists(db_url):
    #     try:
    #         create_database(db_url)
    #         print("Database pushups-logger created!")
    #     except Exception as e:
    #         print("Error creating database...")
    #         print(e)

    db.init_app(app)

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    from .models import Users

    init_db(app, db)

    @login_manager.user_loader
    def load_user(user_id):
        # since the user_id is just the primary key of our user table, use it in the query for the user
        return Users.query.get(int(user_id))

    # blueprint for auth routes in our app
    from .auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint)

    # blueprint for non-auth parts of app
    from .main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    return app


def init_db(app, db):
    with app.app_context():
        # create tables
        db.drop_all()
        db.create_all()
        db.session.commit()
        print("Created tables: User and Workout!")
