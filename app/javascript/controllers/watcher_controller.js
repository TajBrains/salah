import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
    static targets = ["timesWindow", "iqamahWindow"];

    static values = {
        times: { type: Array, default: [] },
        callbackUrl: String,
    };

    connect() {
        this.checkPrayerTimes();
        this.startInterval();
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

        const prayTimes = this.timesValue
            .map((prayTime) => new Date(prayTime))
            .filter((dateObject) => !isNaN(dateObject.getTime()));

        const timeForIqamah = 60 * 1000; // 2 minutes in milliseconds

        prayTimes.forEach((prayTime) => {
            const timeDifference = currentTime -  prayTime;

            if (timeDifference <= timeForIqamah && timeDifference > 0) {
                this.showIqamahWindow();
            } else {
                this.showTimesWindow();
            }
        });
    }

    isMidnight(currentTime) {
        return currentTime.getHours() === 0 && currentTime.getMinutes() === 0 && currentTime.getSeconds() === 0;
    }

    showIqamahWindow() {
        $("#timesWindow").addClass("hidden");
        $("#iqamahWindow").removeClass("hidden").hide().fadeIn(1000);
    }

    showTimesWindow() {
        $("#timesWindow").removeClass("hidden");
        $("#iqamahWindow").addClass("hidden");
    }
}
