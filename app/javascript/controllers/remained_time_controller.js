import ApplicationController from 'controllers/application_controller'

export default class extends ApplicationController {
    static targets = ["time"];
    static values = { nextTime: String }

    connect() {
        this.updateTime();

        // Set up a timer to call updateTime() every second (1000ms)
        this.remainedTimeTimer = setInterval(() => {
            this.updateTime();
        }, 1000);
    }

    disconnect() {
        clearInterval(this.remainedTimeTimer);
    }

    updateTime() {
        const now = new Date();
        const nextTime = new Date(this.nextTimeValue);

        // Calculate the difference between active and next times in milliseconds
        const differenceInMs = nextTime - now + 1000;

        // Convert milliseconds to hours, minutes, and seconds
        const hours = String(Math.floor(differenceInMs / 3600000)).padStart(2, '0');
        const minutes = String(Math.floor((differenceInMs % 3600000) / 60000)).padStart(2, '0');
        const seconds = String(Math.floor((differenceInMs % 60000) / 1000)).padStart(2, '0');

        const remainedTime = `${hours}:${minutes}:${seconds}`;

        this.timeTarget.textContent = remainedTime;

        if (remainedTime === '00:00:00' || remainedTime.includes('-')) {
            super.dispatchReload();
        }
    }
}
