from robot.api import ExecutionResult

def get_test_status(path, type):
    result = ExecutionResult(path)

    # Variáveis para armazenar resultados
    total_success = 0
    total_failures = 0
    failed_tests = []

    # Iterar sobre os testes no resultado
    for test in result.suite.tests:
        test_name = test.name
        test_success = True

        for keyword in test.body:

            if keyword.status != 'PASS':
                test_success = False

        if test_success:
            total_success += 1
        else:
            total_failures += 1
            failed_tests.append(test_name)

    message = f'Resultados dos Testes da visão {type}:\n'
    message += f'Total de casos com sucesso: {total_success}\n'
    message += f'Total de casos com falha: {total_failures}\n'

    if total_failures > 0:
        message += 'Casos com falha:\n'
        for failed_test in failed_tests:
            message += f' ❌ {failed_test}\n'

    return message
