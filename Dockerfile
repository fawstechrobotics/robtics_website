FROM python:3.9

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install ffmpeg (includes ffprobe) before Python requirements
RUN apt-get update && apt-get install -y ffmpeg

COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt && pip install python-dateutil

COPY . .

EXPOSE 8000

CMD ["sh", "-c", "python3.9 manage.py makemigrations && python3.9 manage.py migrate && python3.9 manage.py runserver 0.0.0.0:8000"]

