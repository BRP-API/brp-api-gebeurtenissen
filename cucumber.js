const baseConfig = {
    require: [
        'features/step_definitions/**/*.ts'
    ],
    requireModule: ['ts-node/register']
};

module.exports = {
    default: {
        ...baseConfig,
        worldParameters: {
            logger: {
                level: 'warn'
            },
        }
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
    }
};
