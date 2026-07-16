// import {WireMock} from 'wiremock-captain';
// import {logger} from './logger';

// export class WiremockManager {
//   private static instance: WiremockManager | undefined;
//   private readonly _wireMock: WireMock;

//   constructor(wireMockBaseUrl: string) {
//     this._wireMock = new WireMock(wireMockBaseUrl);
//   }

//   public static async setup(wireMockBaseUrl: string): Promise<void> {
//     WiremockManager.instance ??= new WiremockManager(wireMockBaseUrl);
//   }

//   public async reset(): Promise<void> {
//     await this.wireMock?.clearAllRequests();
//   }

//   public static getInstance(): WiremockManager {
//     if (!WiremockManager.instance) {
//       throw new Error(
//         'WiremockManager is not initialized. Call setup() first.',
//       );
//     }
//     return WiremockManager.instance;
//   }

//   get wireMock(): WireMock {
//     return this._wireMock;
//   }

//   public static async getLastRequestBody(): Promise<any> {
//     const requests: any[] =
//       await WiremockManager.getInstance().wireMock.getAllRequests();
//     if (requests.length === 0) {
//       logger.error('No Wiremock requests found');
//       throw new Error('No Wiremock requests found');
//     }
//     const lastRequestBody = JSON.parse(
//       requests[requests.length - 1].request.body,
//     );
//     logger.debug('WiremockManager.getLastRequestBody', lastRequestBody);
//     return lastRequestBody;
//   }
// }
