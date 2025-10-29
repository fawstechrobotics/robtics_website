FROM python:3.9

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y ffmpeg

# Copy and install Python requirements
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt && pip install python-dateutil gunicorn

# Copy project files
COPY . .

# Expose port for Gunicorn
EXPOSE 8000

# Run migrations and start Gunicorn
CMD ["sh", "-c", "python3.9 manage.py makemigrations && python3.9 manage.py migrate && gunicorn fawstech_robotics.wsgi:application --bind 0.0.0.0:8000 --workers 3 --timeout 3600"]
