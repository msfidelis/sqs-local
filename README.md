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
