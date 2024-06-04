FROM python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ADD main.py .
ADD index.html .

COPY data.json /app/data.json

EXPOSE 8081

CMD ["python", "main.py"]