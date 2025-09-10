from flask import Flask, render_template
import mysql.connector

app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Welcome to my Monolithic App</h1><p>Frontend + Backend + DB in one stack</p>"

@app.route("/db")
def db_connect():
    try:
        connection = mysql.connector.connect(
            host="YOUR_RDS_ENDPOINT",
            user="YOUR_DB_USER",
            password="YOUR_DB_PASSWORD",
            database="YOUR_DB_NAME"
        )
        cursor = connection.cursor()
        cursor.execute("SELECT NOW();")
        result = cursor.fetchone()
        return f"<h3>Connected to DB! Current time: {result}</h3>"
    except Exception as e:
        return f"DB connection failed: {str(e)}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

