set (OPENSSL_USE_STATIC_LIBS ${USE_STATIC_LIBRARIES})
if (APPLE)
    set (OPENSSL_ROOT_DIR "/usr/local/opt/openssl")
endif ()
find_package (OpenSSL)
if (NOT OPENSSL_FOUND)
    # Try to find manually.
    set (OPENSSL_INCLUDE_PATHS "/usr/local/opt/openssl/include")
    set (OPENSSL_PATHS "/usr/local/opt/openssl/lib")
    find_path (OPENSSL_INCLUDE_DIR NAMES openssl/ssl.h PATHS ${OPENSSL_INCLUDE_PATHS})
    find_library (OPENSSL_SSL_LIBRARY ssl PATHS ${OPENSSL_PATHS})
    find_library (OPENSSL_CRYPTO_LIBRARY crypto PATHS ${OPENSSL_PATHS})
    if (OPENSSL_SSL_LIBRARY AND OPENSSL_CRYPTO_LIBRARY AND OPENSSL_INCLUDE_DIR)
        set (OPENSSL_LIBRARIES ${OPENSSL_SSL_LIBRARY} ${OPENSSL_CRYPTO_LIBRARY})
        set (OPENSSL_FOUND 1)
    endif ()
endif ()

if (OPENSSL_FOUND)
    include_directories (${OPENSSL_INCLUDE_DIR})
endif ()

message (STATUS "Using openssl=${OPENSSL_FOUND}: ${OPENSSL_INCLUDE_DIR} : ${OPENSSL_LIBRARIES}")
