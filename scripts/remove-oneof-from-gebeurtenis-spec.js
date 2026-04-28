const fs = require('fs');
const path = require('path');

/**
 * Maakt een extra specificatie aan voor gebeurtenissen-bevragen-service en verwijdert de oneOf uit de Gebeurtenis definitie in de OpenAPI specificatie, zodat deze beter te gebruiken is met openapi-generator voor java-spring.
 *
 * node ./scripts/remove-oneof-from-gebeurtenis-spec.js
 *
 * OAS3.0 feature support voor anyOf, oneOf, callbacks, etc staan op de short-term roadmap van openapi-generator. https://openapi-generator.tech/docs/roadmap
 */

const sourcePath = process.argv[2]
    ? path.resolve(process.argv[2])
    : path.resolve(
        __dirname,
        '..',
        'specificaties',
        'gebeurtenissen-bevragen-service',
        'resolved',
        'openapi.yaml'
    );

const outputPath = process.argv[3]
    ? path.resolve(process.argv[3])
    : path.join(path.dirname(sourcePath), 'openapi-java-spring.yaml');

const gebeurtenisBlock = `    Gebeurtenis:
      type: object
      properties:
        id:
          $ref: '#/components/schemas/iddef'
        source:
          $ref: '#/components/schemas/sourcedef'
        specversion:
          $ref: '#/components/schemas/specversiondef'
        type:
          $ref: '#/components/schemas/typedef'
      required:
        - id
        - source
        - specversion
        - type
      oneOf:
        - $ref: '#/components/schemas/VerhuisdIntergemeentelijk'
        - $ref: '#/components/schemas/VerhuisdNaarBuitenland'
        - $ref: '#/components/schemas/Overleden'
      discriminator:
        propertyName: type
        mapping:
          nl.brp.verhuisd.intergemeentelijk: '#/components/schemas/VerhuisdIntergemeentelijk'
          nl.brp.verhuisd.naar-buitenland: '#/components/schemas/VerhuisdNaarBuitenland'
          nl.brp.overleden: '#/components/schemas/Overleden'`;

const gebeurtenisBlockWithoutOneof = `    Gebeurtenis:
      type: object
      properties:
        id:
          $ref: '#/components/schemas/iddef'
        source:
          $ref: '#/components/schemas/sourcedef'
        specversion:
          $ref: '#/components/schemas/specversiondef'
        type:
          $ref: '#/components/schemas/typedef'
      required:
        - id
        - source
        - specversion
        - type
      discriminator:
        propertyName: type
        mapping:
          nl.brp.verhuisd.intergemeentelijk: '#/components/schemas/VerhuisdIntergemeentelijk'
          nl.brp.verhuisd.naar-buitenland: '#/components/schemas/VerhuisdNaarBuitenland'
          nl.brp.overleden: '#/components/schemas/Overleden'`;

function replaceFirstOccurrence(input, current, replacement) {
    const occurrences = input.split(current).length - 1;

    if (occurrences === 0) {
        throw new Error('Geen match gevonden. Controleer of het element bestaat in de specificatie.');
    }

    const transformed = input.replace(current, replacement);

    console.log('Match gevonden en vervangen');

    return transformed;
}

const source = fs.readFileSync(sourcePath, 'utf8');

let transformed = replaceFirstOccurrence(source, gebeurtenisBlock, gebeurtenisBlockWithoutOneof);

fs.writeFileSync(outputPath, transformed, 'utf8');

console.log(`${path.relative(process.cwd(), outputPath)}`);