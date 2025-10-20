export class CloudEvent {
    type: string;
    data?: any;

    constructor(type: string, data?: any) {
        this.type = type;
        if(data) {
            this.data = data;
        }
    }
}
