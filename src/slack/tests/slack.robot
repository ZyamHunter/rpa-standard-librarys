*** Settings ***
Library     RPA.Slack


*** Tasks ***
Enviar mensagem pro slack pelo Webhook
    Slack Message Using Webhook
    ...    webhook_url=https://hooks.slack.com/services/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
    ...    channel=canal-test-boticario
    ...    sender=RPA - Yam Carrasco
    ...    text=Teste Slack Webhook by Robot Framework
    ...    icon_emoji=🤖

Mensagem slack
    Slack Raw Message
    ...    webhook=https://hooks.slack.com/services/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
    ...    message=Simple Message For Slack Webhook
    ...    channel=canal-test-boticario
