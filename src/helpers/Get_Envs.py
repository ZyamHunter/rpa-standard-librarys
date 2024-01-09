import os
from dotenv import load_dotenv


def get_enviroment_variables():
    load_dotenv()

    environment_variables = {
        'JWE_KEY': os.getenv('JWE_KEY')
    }

    return environment_variables