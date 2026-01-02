/**
 * Normalize a fetch Response into a ParsedResponseObject.
 */
export async function parseResponse(response: Response): Promise<ParsedResponseObject> {
    const contentType = response.headers?.get?.('content-type') ?? '';
    let body: unknown;
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

interface ParsedResponseObject {
    status: number;
    body: unknown;
}