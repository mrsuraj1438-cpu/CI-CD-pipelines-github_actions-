
FROM python:3.14-slim AS builder

WORKDIR /app

COPY requirements.txt .

ADD /templates/index.html /app/templates/index.html

RUN pip install -r requirements.txt --target /app/package


# stage 2: deployer

FROM gcr.io/distroless/python3-debian12

WORKDIR /app

COPY --from=builder /app/package /app/package
COPY --from=builder /app /app/