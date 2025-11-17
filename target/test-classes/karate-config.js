function fn() {
    // Configuración de timeouts
    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout', 10000);
    // karate.configure('abortSuiteOnFailure', true);

    // Configuración de ambiente
    // Por defecto usa 'prod' si no se especifica
    var env = karate.env || 'prod';
    
    var protocol = 'https';
    var server = 'parabank.parasoft.com';
    
    // Ambiente local (usar variable de entorno o configuración)
    if (env == 'local') {
        protocol = 'http';
        // Permitir configuración mediante variable de entorno
        server = karate.properties['local.server'] || '192.168.0.182:8080';
    }
    
    // Ambiente de producción (por defecto)
    if (env == 'prod') {
        protocol = 'https';
        server = 'parabank.parasoft.com';
    }

    var config = {
        baseUrl: protocol + '://' + server + '/parabank/services/bank',
        env: env
    };
    
    // Configurar Faker para generación de datos de prueba
    config.faker = Java.type('com.github.javafaker.Faker');

    return config;
}