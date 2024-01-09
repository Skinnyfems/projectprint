from flask import jsonify

from database import db, User
from core import app

from flasgger import Swagger, swag_from, Schema


swagger_config = {
    "headers": [
    ],
    "specs": [
        {
            "endpoint": 'swagger',
            "route": '/swagger.json',
            "rule_filter": lambda rule: True,  # all in
            "model_filter": lambda tag: True,  # all in
        }
    ],
    "static_url_path": "/flasgger_static",
    # "static_folder": "static",  # must be set by user
    "swagger_ui": True,
    "specs_route": "/swagger/"
}

swagger = Swagger(app, config=swagger_config)


@app.route('/', methods=('GET',))
def root():
    return jsonify(message="hello :)")


@app.route('/register', methods=('POST',))
def register():
    users = db.session.execute(db.select(User).order_by(User.username)).scalars()
    serialized_users = [user.as_dict() for user in users]
    return jsonify(message=serialized_users)


@app.route('/login', methods=('POST',))
def login():
    users = db.session.execute(db.select(User).order_by(User.username)).scalars()
    serialized_users = [user.as_dict() for user in users]
    return jsonify(message=serialized_users)


@app.route('/account', methods=('GET', 'POST', 'PUT'))
def account():
    users = db.session.execute(db.select(User).order_by(User.username)).scalars()
    serialized_users = [user.as_dict() for user in users]
    return jsonify(message=serialized_users)


@app.route('/supplier', methods=('GET', 'POST', 'PUT'))
def supplier():
    users = db.session.execute(db.select(User).order_by(User.username)).scalars()
    serialized_users = [user.as_dict() for user in users]
    return jsonify(message=serialized_users)


@app.route('/material', methods=('GET', 'POST', 'PUT'))
def material():
    users = db.session.execute(db.select(User).order_by(User.username)).scalars()
    serialized_users = [user.as_dict() for user in users]
    return jsonify(message=serialized_users)
