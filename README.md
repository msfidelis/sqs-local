# sqs-local
Docker Image for run Amazon SQS Locally using ElasticMQ - Don't use in production!!!

## Running on Docker

```bash
$ docker pull msfidelis/sqs
```

#### Docker Compose example
```yml
version: "3"

services:
  dynamodb:
    image: msfidelis/dynamodb
    volumes:
      - ./database:/database
    ports:
      - "9324:9324"
```