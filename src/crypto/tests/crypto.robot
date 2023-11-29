*** Settings ***
Documentation       Library for common encryption and hashing operations.

Library             RPA.Crypto


*** Tasks ***
Generate Key
    ${GENERATED_KEY}=    Generate Key

Encrypt File
    ${GENERATED_KEY}=    Generate Key
    Use encryption key    ${GENERATED_KEY}
    Set Suite Variable    ${KEY_TO_ENCRYPT_FILE}    ${GENERATED_KEY}
    ${PATH}=    Encrypt file    path=src\\crypto\\assets\\users.json
    Set Suite Variable    ${ENCRYPTED_FILE}    ${PATH}

Encrypt String
    ${GENERATED_KEY}=    Generate Key
    Use encryption key    ${GENERATED_KEY}
    Set Suite Variable    ${KEY_TO_ENCRYPT_STRING}    ${GENERATED_KEY}
    ${TOKEN_ENCRYPTED}=    Encrypt string    This is a secret, don't share it
    Set Suite Variable    ${TOKEN_ENCRYPTED}    ${TOKEN_ENCRYPTED}

Decrypt File
    Use encryption key    ${KEY_TO_ENCRYPT_FILE}
    ${PATH}=    Decrypt file    ${ENCRYPTED_FILE}

Decrypt String
    Use encryption key    ${KEY_TO_ENCRYPT_STRING}
    ${PATH}=    Decrypt String    ${TOKEN_ENCRYPTED}

Hash File
    ${HASH_FILE}=    Hash file    src\\crypto\\assets\\users.json    method=MD5
    Should not be equal    ${HASH_FILE}    uSlyRHlbu8NzY29YMZhDUpdErP4=

    ${OTHER_HASH_FILE}=    Hash file    src\\crypto\\assets\\users.json    method=SHA1
    Should not be equal    ${OTHER_HASH_FILE}    uSlyRHlbu8NzY29YMZhDUpdErP4=

Hash String
    ${OTHER_HASH_STRING}=    Hash string    A value that will be hashed    SHA1
    Should be equal    ${OTHER_HASH_STRING}    uSlyRHlbu8NzY29YMZhDUpdErP4=

Use Encryption Key
    ${GENERATED_KEY}=    Generate Key
    Use encryption key    ${GENERATED_KEY}

# Use Encryption Key From Vault
#    Use Encryption Key From Vault    name=Encryption    key=CryptoKey
