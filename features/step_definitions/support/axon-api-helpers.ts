import {EventSource} from 'eventsource';
import {logger} from './logger.js';

const PayloadTypeMap: {[key: string]: string} = {
  'nl.rvig.brpapi.gebeurtenissen.web.api.v1.VerhuisdIntergemeentelijkData':
    'nl.brp.verhuisd.intergemeentelijk',
};

export async function getLastEventFrom(aggregateId: string): Promise<any> {
  const response = await fetch(
    `${process.env.AXON_API_BASE_URL}/v2/aggregates/${aggregateId}/events?context=default&payloadContentType=application/json`,
    {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    },
  );

  const data: any = await response.json();

  const lastEvent = data[data.length - 1];

  return {
    type: PayloadTypeMap[lastEvent.payloadType],
    data: lastEvent.payload,
  };
}

export async function getFirstEventMatching(
  after: Date,
  cloudEventType: string,
  a_nr: string,
): Promise<any> {
  return new Promise((resolve, reject) => {
    const queryUrl = `${process.env.MUTATIE_BASE_URL}/events?after=${after.toISOString()}`;
    const es = new EventSource(queryUrl);
    const axonEventType = axonEventTypeFor(cloudEventType);
    const timeout = setTimeout(() => {
      cleanup();
      reject(
        new Error(
          `Event of type ${cloudEventType} not found for query ${queryUrl}`,
        ),
      );
    }, 3_000);

    const cleanup = () => {
      clearTimeout(timeout);
      es.removeEventListener(axonEventType, handler);
      es.close();
    };

    const handler = (event: MessageEvent) => {
      try {
        const data = JSON.parse(event.data);
        logger.debug('Received axon event', event);

        if (String(data.gebeurtenisCriteriaId.anummer) === a_nr) {
          logger.debug('Matched axon event', data);
          cleanup();
          resolve(data);
        }
      } catch (err) {
        cleanup();
        reject(err);
      }
    };

    es.addEventListener(axonEventType, handler);

    es.onerror = err => {
      cleanup();
      reject(err);
    };
  });
}

function axonEventTypeFor(cloudEventType: string): string {
  switch (cloudEventType) {
    case 'verhuisd.naar-buitenland':
      return 'nl.rvig.brpapi.gebeurtenissen.EmigratieVerhuisd';
    default:
      throw new Error(`Unknown cloud event type: ${cloudEventType}`);
  }
}
