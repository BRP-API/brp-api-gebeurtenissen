const fs = require('node:fs');
const path = require('node:path');
const { processFile } = require('./process-cucumber-file');

const outputFile = path.join(__dirname, './../test-reports/cucumber-js/step-summary.txt');
fs.writeFileSync(outputFile, '', 'utf8');

const fileMap = new Map([
    ["./../test-reports/cucumber-js/docs/test-result-summary.txt", "docs (zonder integratie)"],
    ["./../test-reports/cucumber-js/docs/test-result-integratie-summary.txt", "docs (integratie)"],
    ["./../test-reports/cucumber-js/abonnementen-service/test-result-summary.txt", "abonnementen service"],
    ["./../test-reports/cucumber-js/e2e/test-result-summary.txt", "end to end"]
]);

fileMap.forEach((caption, filePath) => {
    processFile(path.join(__dirname, filePath), outputFile, caption);
});