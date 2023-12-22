from flask import Flask, request, jsonify
from flask_bcrypt import Bcrypt
import mysql.connector

app = Flask(__name__)
bcrypt = Bcrypt(app)

# Koneksi ke MySQL
db_connection = mysql.connector.connect(
    host="localhost",
    user="username",
    password="password",
    database="nama_database"
)

# Endpoint untuk login
@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    cursor = db_connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE username=%s", (username,))
    user = cursor.fetchone()
    cursor.close()

    if user and bcrypt.check_password_hash(user['password_hash'], password):
        return jsonify({'message': 'Login berhasil'}), 200
    else:
        return jsonify({'message': 'Login gagal'}), 401

# Endpoint untuk registrasi (join)
@app.route('/api/join', methods=['POST'])
def join():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password_hash')
    email = data.get('email')
    full_name = data.get('full_name')
    code_invit = data.get('code_invit')

    # Hash password menggunakan bcrypt
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

    # Cek apakah kode undangan valid
    cursor = db_connection.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE code_invit=%s", (code_invit,))
    existing_user = cursor.fetchone()
    cursor.close()

    if existing_user:
        return jsonify({'message': 'Kode undangan tidak valid'}), 400

    # Simpan data registrasi ke database
    cursor = db_connection.cursor()
    cursor.execute(
        "INSERT INTO users (username, password_hash, email, full_name, code_invit) VALUES (%s, %s, %s, %s, %s)",
        (username, hashed_password, email, full_name, code_invit)
    )
    db_connection.commit()
    cursor.close()

    return jsonify({'message': 'Registrasi berhasil'}), 201

if __name__ == '__main__':
    app.run(debug=True)
