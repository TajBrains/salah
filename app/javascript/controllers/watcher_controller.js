import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
    static targets = ["time"];
    static values = {
        times: { type: Array, default: [] },
        callbackUrl: String,
        turboInactivityTimer: { type: Number, default: 30 * 60 * 1000 }
    };

    connect() {
        this.checkPrayerTimes();
        this.startInterval();
        this.startTurboInactivityTimer()
    }

    disconnect() {
        this.stopInterval();
    }

    startInterval() {
        this.interval = setInterval(this.checkPrayerTimes.bind(this), 1000);
    }

    stopInterval() {
        clearInterval(this.interval);
    }

    checkPrayerTimes() {
        const currentTime = new Date();

        if (this.isMidnight(currentTime)) {
            super.dispatchReload();
        }

        const prayTimes = this.timesValue.map((prayTime) => new Date(prayTime)).filter((dateObject) => !isNaN(dateObject.getTime()));

        prayTimes.forEach((prayTime) => {
            if (this.isSameTime(currentTime, prayTime)) {
                super.dispatchReload();
            }
        });
    }

    isMidnight(currentTime) {
        return currentTime.getHours() === 0 && currentTime.getMinutes() === 0 && currentTime.getSeconds() === 0;
    }

    isSameTime(time1, time2) {
        return (
            time1.getHours() === time2.getHours() &&
            time1.getMinutes() === time2.getMinutes() &&
            time1.getSeconds() === time2.getSeconds()
        );
    }

    startTurboInactivityTimer = () => {
        this.inactivityTimer = setTimeout(() => {
            super.dispatchReload()
        }, this.turboInactivityTimerValue);
    };
}
