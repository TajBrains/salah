import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
    static targets = ["timesWindow", "iqamahWindow"];

    static values = {
        times: { type: Array, default: [] },
        activeTime: String,
        hasAnyAnnouncement: Boolean
    };

    get activeTime() {
        return new Date(this.activeTimeValue);
    }

    connect() {
        this.checkPrayerTimes();
        this.startInterval();
        this.startAnnouncementInterval();
    }

    disconnect() {
        clearInterval(this.interval);
        clearInterval(this.announcementInterval);
    }

    startInterval() {
        this.interval = setInterval(this.checkPrayerTimes.bind(this), 1000);
    }

    startAnnouncementInterval() {
        if (this.hasAnyAnnouncementValue) {
            this.announcementInterval = setInterval(this.showAnnouncements.bind(this), 3 * 1000)
        }
    }

    showAnnouncements() {
        if (!this.iqamahWindowActive) {
            $("#timesWindow").addClass("hidden");
            $("#announcementsWindow").removeClass("hidden");
        }
    }

    checkPrayerTimes() {
        const currentTime = new Date();

        if (this.isMidnight(currentTime)) {
            super.dispatchReload();
        }

        const prayTimes = this.timesValue
            .map((prayTime) => new Date(prayTime))
            .filter((dateObject) => !isNaN(dateObject.getTime()));

        const timeForIqamah = 60 * 1000; // 1 minutes in milliseconds

        prayTimes.forEach((prayTime) => {
            if (prayTime.getTime() === this.activeTime.getTime()) {
                const timeDifference = currentTime - prayTime;

                if (timeDifference <= timeForIqamah && timeDifference > 0) {
                    this.showIqamahWindow();
                } else {
                    this.showTimesWindow();
                }
            }
        });
    }

    isMidnight(currentTime) {
        return currentTime.getHours() === 0 && currentTime.getMinutes() === 0 && currentTime.getSeconds() === 0;
    }

    showIqamahWindow() {
        this.iqamahWindowActive = true;
        $("#timesWindow").addClass("hidden");
        $("#iqamahWindow").removeClass("hidden");
    }

    showTimesWindow() {
        this.iqamahWindowActive = false;
        $("#timesWindow").removeClass("hidden");
        $("#iqamahWindow").addClass("hidden");
    }
}
