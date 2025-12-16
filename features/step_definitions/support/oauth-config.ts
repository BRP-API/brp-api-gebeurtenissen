import * as dotenv from "dotenv";

dotenv.config();

export const oauthConfig = {
    masterRealm: {
        accessTokenUrl: `${process.env.KC_BASE_URL}/realms/master/protocol/openid-connect/token`,
        username: process.env.KC_MASTER_USERNAME || '',
        password: process.env.KC_MASTER_PASSWORD || ''
    },
    brpApiRealm: {
        adminBaseUrl: `${process.env.KC_BASE_URL}/admin/realms/brp-api`,
        accessTokenUrl: `${process.env.KC_BASE_URL}/realms/brp-api/protocol/openid-connect/token`
    }
};