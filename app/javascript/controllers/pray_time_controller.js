import ApplicationController from 'controllers/application_controller'

export default class extends ApplicationController {
    static targets = ["time"];
    static values = {
        times: { type: Array, default: [] },
        interval: { type: Number, default: 5000 },
    };

    connect() {
        this.currentIndex = 0;
        this.updateTime();

        this.intervalId = setInterval(() => {
            this.currentIndex = (this.currentIndex + 1) % this.timesValue.length;
            this.updateTime();
        }, this.intervalValue);
    }

    updateTime() {
        this.timeTarget.textContent = this.timesValue[this.currentIndex];
    }

    disconnect() {
        clearInterval(this.intervalId);
    }
}
