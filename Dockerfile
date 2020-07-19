FROM python:3.8 as build
WORKDIR /code
# Assuming /code is mounted as volume:
# docker build -v "$PWD":/code -t docker-dev-services
RUN pip install -r requirements.txt
COPY src/ .
#CMD [ "python", "./server.py" ]
