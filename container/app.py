from flask import Flask, render_template_string
import psycopg2
import os

app = Flask(__name__)

# 環境変数からRDS接続情報を取得
RDS_HOST = os.getenv('RDS_HOST')
RDS_PORT = os.getenv('RDS_PORT', 5432)
RDS_DBNAME = os.getenv('RDS_DBNAME')
RDS_USER = os.getenv('RDS_USER')
RDS_PASSWORD = os.getenv('RDS_PASSWORD')

@app.route('/')
def index():
    return render_template_string('''
        <html>
            <head>
                <title>RDS Connection Test</title>
            </head>
            <body>
                <h1>RDS Connection Test</h1>
                <button onclick="location.href='/check'">DBに接続</button>
            </body>
        </html>
    ''')

@app.route('/check')
def check():
    try:
        connection = psycopg2.connect(
            host=RDS_HOST,
            port=RDS_PORT,
            dbname=RDS_DBNAME,
            user=RDS_USER,
            password=RDS_PASSWORD,
            connect_timeout=5
        )
        connection.close()
        return "データベースに接続できました"
    except Exception as e:
        return f"データベースに接続できませんでした: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)