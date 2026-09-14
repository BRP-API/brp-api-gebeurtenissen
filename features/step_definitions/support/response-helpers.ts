async function parseResponseBody(response: Response): Promise<any> {
  const responseText = await response.text();

  if (!responseText) {
    return null;
  }

  try {
    return JSON.parse(responseText);
  } catch {
    return responseText;
  }
}

export async function parseResponse(response: Response): Promise<any> {
  return {
    statusCode: response.status,
    body: await parseResponseBody(response),
  };
}
