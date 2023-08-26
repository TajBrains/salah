import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ["announcement"];

    connect() {
        this.currentIndex = 0;
        this.showNextAnnouncement();
    }

    showNextAnnouncement() {
        if (this.hasAnnouncementTarget) {
            this.hideAllAnnouncements();

            const currentAnnouncement = this.announcementTargets[this.currentIndex];
            this.showAnnouncement(currentAnnouncement);

            this.currentIndex = (this.currentIndex + 1) % this.announcementTargets.length;

            setTimeout(() => {
                this.showNextAnnouncement();
            }, parseInt($(currentAnnouncement).data("duration")) * 1000);
        }
    }

    hideAllAnnouncements() {
        this.announcementTargets.forEach(announcement => {
            this.hideAnnouncement(announcement);
        });
    }

    hideAnnouncement(announcement) {
        announcement.classList.add("hidden");
    }

    showAnnouncement(announcement) {
        announcement.classList.remove("hidden");
    }
}
