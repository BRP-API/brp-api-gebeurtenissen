import {expect} from 'chai';
import {expectEventuallyWithRetry} from './custom-assertions/expectEventually.js';

export class ProcessedGebeurtenisManager {
  private static instance: ProcessedGebeurtenisManager =
    new ProcessedGebeurtenisManager();

  static getInstance(): ProcessedGebeurtenisManager {
    return ProcessedGebeurtenisManager.instance;
  }

  async reset() {
    const response = await fetch(
      `${process.env.GEBEURTENISSEN_BASE_URL}/actuator/gebeurtenissen/reset`,
      {
        method: 'POST',
      },
    );
    expect(
      response.status,
      `Reset failed with status ${response.status}`,
    ).to.equal(204);
  }

  async getProcessedGebeurtenissen(): Promise<ProcessedGebeurtenis[]> {
    const response = await fetch(
      `${process.env.GEBEURTENISSEN_BASE_URL}/actuator/gebeurtenissen`,
      {
        method: 'GET',
      },
    );
    expect(
      response.status,
      `Get processed gebeurtenissen failed with status ${response.status}`,
    ).to.equal(200);
    return (await response.json()) as ProcessedGebeurtenis[];
  }

  async awaitGebeurtenissenProcessed(id: string): Promise<void> {
    await expectEventuallyWithRetry(
      await this.getProcessedGebeurtenissen(),
      async () => await this.getProcessedGebeurtenissen(),
      gebeurtenissen =>
        expect(gebeurtenissen as ProcessedGebeurtenis[]).to.satisfy(
          (gebeurtenissen: ProcessedGebeurtenis[]) =>
            (gebeurtenissen as ProcessedGebeurtenis[]).some(
              gebeurtenis => gebeurtenis.id === id,
            ),
        ),
    );
  }
}

export interface ProcessedGebeurtenis {
  id: string;
  type: string;
  bsn: string;
}
