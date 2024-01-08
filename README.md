[![Standard](https://github.com/ZyamHunter/rpa-standard-librarys/actions/workflows/standard.yaml/badge.svg)](https://github.com/ZyamHunter/rpa-standard-librarys/actions/workflows/standard.yaml)

# rpa-standard-librarys
> Repositório de testes dedicados ao uso das mais variadas bibliotecas do robot framework, especificamente a rpaframework

# Configuração do Ambiente

## 1. Instalar Python 3.10

Certifique-se de ter o Python 3.10 instalado em seu sistema. Você pode baixá-lo no [site oficial do Python](https://www.python.org/).

## 2. Instalar Ambiente Virtual

Instale a ferramenta `virtualenv` para criar ambientes virtuais de aprendizado:

- pip install virtualenv

## 3. Criar um ambiente virtual:
- python -m venv project-venv

## 4. Se você estiver usando o PowerShell e encontrar problemas para executar scripts, talvez precise alterar a política de execução temporariamente para permitir a execução de scripts:
- Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

## 5. Ativar o ambiente virtual:
- .\project-venv\Scripts\activate

## 6. Remover cache do pip
- pip cache remove *

## 7. Rodar os testes
- robot -d logs ./src

## 8. Desativar ambiente virtual
- deactivate

### Bibliotecas utilizadas nas tasks criadas

* archive
* assistant
* calendar
* crypto
* excel_app
* excel_files
* fileSystem
* http
* image
* json
* operatingSystem
* pdf
* robotLogListener
* slack
* tables
* tasks
* word_app
