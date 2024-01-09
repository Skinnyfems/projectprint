import settings

import uuid
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy import text
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


def generate_uuid():
    return str(uuid.uuid4())


class User(db.Model):
    id = db.Column(db.CHAR(36), unique=True, nullable=False, primary_key=True, server_default=text('(UUID())'))
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.TEXT, nullable=True)

    def as_dict(self):
        return {column.name: getattr(self, column.name) for column in self.__table__.columns}


class Supplier(db.Model):
    id = db.Column(db.CHAR(36), unique=True, nullable=False, primary_key=True, server_default=text('(UUID())'))
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.TEXT, nullable=True)

    def as_dict(self):
        return {column.name: getattr(self, column.name) for column in self.__table__.columns}


class Material(db.Model):
    id = db.Column(db.CHAR(36), unique=True, nullable=False, primary_key=True, server_default=text('(UUID())'))
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.TEXT, nullable=True)

    def as_dict(self):
        return {column.name: getattr(self, column.name) for column in self.__table__.columns}


def attach_db(app: Flask) -> Flask:
    app.config[
        'SQLALCHEMY_DATABASE_URI'] = f'mysql://{settings.DB_USER}:{settings.DB_PASSWORD}@{settings.DB_HOST}:{settings.DB_PORT}/{settings.DB_NAME}'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)
    return app
