/**
 * Normalize a fetch Response into an object
 */
export async function parseResponse(response: Response) {
    const contentType = response.headers?.get?.('content-type') ?? '';
    let body: { };
    if (contentType.includes('application/json')) {
        try {
            body = await response.json();
        } catch {
            body = await response.text();
        }
    } else {
        const text = await response.text();
        try {
            body = JSON.parse(text);
        } catch {
            body = text;
        }
    }
    return { status: response.status, body };
}