import os
import shutil
from database import db
from routes import app


if __name__ == '__main__':
    with app.app_context():
        if os.path.exists('migrations'):
            shutil.rmtree("migrations")
            print("remove migrations . . .")
        os.system("flask db init")
        db.drop_all()
        db.create_all()
        os.system("flask db migrate -m 'Automatic migration'")
        os.system("flask db upgrade")

    app.run(debug=True, host='0.0.0.0')
