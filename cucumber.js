const baseConfig = {
    require: [
        'features/step_definitions/**/*.ts'
    ],
    requireModule: ['ts-node/register']
};

module.exports = {
    default: {
        sql : {
            useDb: true,
            cleanup: true,
            deleteIndividualRecords: true,
            poolConfig: {
                user: 'root',
                host: 'host.docker.internal',
                database: 'rvig_haalcentraal_testdata',
                password: 'root',
                port: 5432,
                allowExitOnIdle: true
            }
        },
        oAuth : {
            enable: false,
            accessTokenUrl: 'http://identityserver:6000/connect/token',
            clients:[
                {
                    afnemerID: '000008',
                    gemeenteCode: '0800',
                    clientId: 'client met gemeentecode (eigen gemeente)',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000080000' ],
                    resourceServer: 'ResourceServer02'
                },
                {
                    afnemerID: '000008',
                    gemeenteCode: '0599',
                    clientId: 'client met gemeentecode (ander gemeente)',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000080000' ],
                    resourceServer: 'ResourceServer02'
                },
                {
                    afnemerID: '000008',
                    clientId: 'client zonder gemeentecode',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000080000' ],
                    resourceServer: 'ResourceServer02'
                },
                {
                    afnemerID: '000009',
                    gemeenteCode: '0900',
                    clientId: 'client met gemeentecode (eigen gemeente, bestaand gezag afnemer)',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000090000' ],
                    resourceServer: 'ResourceServer02'
                },
                {
                    afnemerID: '000009',
                    clientId: 'client zonder gemeentecode (bestaand gezag afnemer)',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000090000' ],
                    resourceServer: 'ResourceServer02'
                },
                {
                    afnemerID: '720402',
                    clientId: 'KMAR',
                    clientSecret: 'secret',
                    scopes: [ '000000099000000080000' ],
                    resourceServer: 'ResourceServer02'
                }
            ]
        },
        worldParameters: {
            apiUrl: 'http://localhost:5040/api/brp',
            api: 'gebeurtenissen-api',
            logger: {
                level: 'warn'
            },
        }
    },
    debug: {
        ...baseConfig,
        worldParameters: {
            logger: {
                level: 'debug', // Override logger level for debug
            },
        },
    },
    dev: {
        ...baseConfig,
        worldParameters: {
            logger: {
                level: 'info', // Override logger level for dev
            },
        },
    },
    Docs: {
        ...baseConfig,
        paths: ['features/docs/**/*.feature'], // Only run documentation features
        tags: 'not @integratie',    // Exclude integratie scenarios
        format: [ // output formats and locations
            'json:./test-reports/cucumber-js/docs/test-result.json',
            'summary:./test-reports/cucumber-js/docs/test-result-summary.txt',
            'summary'
        ],
        worldParameters: {
            logger: {
                level: 'warn'
            }
        }
    },
    DocsIntegratie: {
        ...baseConfig,
        paths: ['features/docs/**/*.feature'], // Only run documentation features
        tags: '@integratie',    // Only integratie scenarios
        format: [ // output formats and locations
            'json:./test-reports/cucumber-js/docs/test-result-integratie.json',
            'summary:./test-reports/cucumber-js/docs/test-result-integratie-summary.txt',
            'summary'
        ],
        worldParameters: {
            logger: {
                level: 'warn'
            }
        }
    },
    EndToEnd: {
        ...baseConfig,
        paths: ['features/*.feature'], // Only run end-to-end features
        format: [ // output formats and locations
            'json:./test-reports/cucumber-js/e2e/test-result.json',
            'summary:./test-reports/cucumber-js/e2e/test-result-summary.txt',
            'summary'
        ],
        worldParameters: {
            logger: {
                level: 'warn'
            }
        }
    }
};
