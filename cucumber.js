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
};
