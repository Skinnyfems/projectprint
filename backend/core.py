from flask import Flask
from database import attach_db, db
from flask_migrate import Migrate


def create_app() -> Flask:
    app_build = Flask(__name__)
    app_build = attach_db(app_build)
    Migrate(app_build, db).init_app(app_build)
    return app_build


app = create_app()
