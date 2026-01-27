const PayloadTypeMap: { [key: string]: string } = {
  'nl.rvig.brpapi.gebeurtenissen.web.api.v1.VerhuisdIntergemeentelijkData': 'nl.brp.verhuisd.intergemeentelijk',
};

export async function getLastEventFrom(aggregateId: string): Promise<any> {
  const response = await fetch(
    `${process.env.AXON_API_BASE_URL}/v2/aggregates/${aggregateId}/events?context=default&payloadContentType=application/json`,
    {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    }
  );

  const data = await response.json();

  const lastEvent = data[data.length - 1];

  return {
    type: PayloadTypeMap[lastEvent.payloadType],
    data: lastEvent.payload,
  };
}
