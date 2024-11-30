
FROM ubuntu
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

COPY app.py /app.py  
COPY requirements.txt /requirements.txt


RUN python3 -m venv /venv

ENV PATH="/venv/bin:$PATH"

RUN pip install --no-cache-dir -r requirements.txt

ENV EXAMPLE example

EXPOSE 80

CMD ["python", "/app.py"]

