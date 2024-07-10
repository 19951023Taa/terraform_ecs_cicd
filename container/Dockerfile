FROM python:3.9-slim

WORKDIR /app
COPY . /app

RUN pip install flask psycopg2-binary

ENV RDS_HOST=#エンドポイント
ENV RDS_PORT=#接続ポート
ENV RDS_DBNAME=#データベース名
ENV RDS_USER=#ユーザー名
ENV RDS_PASSWORD=#パスワード

CMD ["python", "app.py"]