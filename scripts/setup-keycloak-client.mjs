#!/usr/bin/env node

import {register} from 'node:module';
import {pathToFileURL} from 'node:url';

register('ts-node/esm', pathToFileURL('./'));

await import('./setup-keycloak-client.ts');