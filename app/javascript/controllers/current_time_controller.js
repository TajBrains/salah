import ApplicationController from 'controllers/application_controller'

export default class extends ApplicationController {
    static targets = ["time"];

    connect() {
        this.updateTime();

        // Set up a timer to call updateTime() every second (1000ms)
        this.currentTimeTimer = setInterval(() => {
            this.updateTime();
        }, 1000);
    }

    disconnect() {
        clearInterval(this.currentTimeTimer);
    }

    updateTime() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const seconds = String(now.getSeconds()).padStart(2, '0');

        this.timeTarget.textContent = `${hours}:${minutes}:${seconds}`;
    }
}
