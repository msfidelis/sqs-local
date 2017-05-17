# sqs-local
Docker Image for run Amazon SQS Locally using ElasticMQ - Don't use in production!!!

## CLI - Docs

> http://docs.amazonaws.cn/cli/latest/reference/sqs/index.html

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

## Configure a AWS Cli (Required) 

You can use Fake Credentials on Development Environment

```
$ aws configure
```

* ACCESS KEY ID: AKIAIOSFODNN7EXAMPLE
* SECRET ACCESS KEY: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

## Creating Queues

### Create a queue in AWS CLI 

```bash
$ aws sqs create-queue --queue-name MyQueue --endpoint http://localhost:9324
```

### Create a Queue with NodeJS 

```javascript
'use strict';

var AWS = require("aws-sdk")

var sqs = new AWS.SQS({
    region: 'us-east-1', 
    endpoint : 'http://localhost:9324'
});

const Queue = "http://localhost:9324"
const Name = "MyQueue"


var params = {
  QueueName: Name,
  Attributes: {
    'DelaySeconds': '60',
    'MessageRetentionPeriod': '86400'
  }
};


sqs.createQueue(params, function(err, data) {
  if (err) {
    console.log("Error", err);
  } else {
    console.log("Success", data.QueueUrl);
  }
});
```

## List Queues

```bash
$ aws sqs list-queues --endpoint http://localhost:9324
```

## Send Message 

### From CLI 

```bash
$ aws sqs send-message --queue-url http://localhost:9324/queue/MyQueue --message-body '{data: "my data"}' --endpoint http://localhost:9324
```
Response: 

```json
{
    "MD5OfMessageBody": "960e4fdc0b7d3aa9f49d4eeae901052a", 
    "MD5OfMessageAttributes": "d41d8cd98f00b204e9800998ecf8427e", 
    "MessageId": "eeeb58ae-1e48-4acc-ab8f-853346cbf86b"
}
```

## Consume Data

Consume data with CLI

```bash
$ aws sqs receive-message --queue-url http://localhost:9324/queue/MyQueue --attribute-names All --max-number-of-messages 2 --endpoint http://localhost:9324
```

Response: 

```json
{
    "Messages": [
        {
            "Body": "{data: \"my data\"}", 
            "ReceiptHandle": "eeeb58ae-1e48-4acc-ab8f-853346cbf86b#0accbc49-0f3c-44bc-bb57-b7825662a859", 
            "MD5OfBody": "960e4fdc0b7d3aa9f49d4eeae901052a", 
            "MD5OfMessageAttributes": "d41d8cd98f00b204e9800998ecf8427e", 
            "MessageId": "eeeb58ae-1e48-4acc-ab8f-853346cbf86b", 
            "Attributes": {
                "ApproximateFirstReceiveTimestamp": "1495038708426", 
                "SenderId": "127.0.0.1", 
                "ApproximateReceiveCount": "1", 
                "SentTimestamp": "1495038580320"
            }
        }, 
        {
            "Body": "{data: \"my data\"}", 
            "ReceiptHandle": "74ef3ad7-b08b-45a8-a88a-c681ce1a0abd#defbedcd-d0bf-44cb-bce8-066a1fdd64d3", 
            "MD5OfBody": "960e4fdc0b7d3aa9f49d4eeae901052a", 
            "MD5OfMessageAttributes": "d41d8cd98f00b204e9800998ecf8427e", 
            "MessageId": "74ef3ad7-b08b-45a8-a88a-c681ce1a0abd", 
            "Attributes": {
                "ApproximateFirstReceiveTimestamp": "1495038708426", 
                "SenderId": "127.0.0.1", 
                "ApproximateReceiveCount": "1", 
                "SentTimestamp": "1495038513175"
            }
        }
    ]
}
```
