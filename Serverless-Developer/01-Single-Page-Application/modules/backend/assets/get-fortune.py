import boto3
import random

TABLE_NAME = 'Fortunes'

fortunes = [
    "Your code will compile on the first try... in an alternate universe.",
    "You will find the bug. Eventually.",
    "A wise programmer once said: 'It works on my machine'.",
    "Your cloud infrastructure will scale... your technical debt.",
    "Beware of the infinite loop in your life.",
    "You will inherit a legacy codebase. Good luck.",
    "The cloud is just someone else's computer... but with better uptime.",
    "Your next deployment will go smoothly. Just kidding.",
    "You will become one with the code... after 10 cups of coffee.",
    "Your pull request will be approved... after 99 comments."
]

def get_dynamodb_table():
    dynamodb = boto3.resource('dynamodb')
    return dynamodb.Table(TABLE_NAME)

def is_table_empty(table):
    response = table.scan(Select='COUNT')
    return response['Count'] == 0

def populate_table(table):
    with table.batch_writer() as batch:
        for i, fortune in enumerate(fortunes, start=1):
            batch.put_item(Item={'id': str(i), 'fortune': fortune})
    print("Database populated successfully.")

def get_random_fortune(table):
    random_id = str(random.randint(1, 10))
    response = table.get_item(Key={'id': random_id})
    return random_id, response.get('Item', {}).get('fortune', "Fortune not found.")

def lambda_handler(event, context):
    table = get_dynamodb_table()

    if is_table_empty(table):
        populate_table(table)

    random_id, fortune = get_random_fortune(table)
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'text/plain',
            'Access-Control-Allow-Origin': '*'  # Properly set header to allow all origins
        },
        'body': f"Fortune #{random_id}: {fortune}"
    }
