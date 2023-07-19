import ApplicationController from 'controllers/application_controller'

export default class extends ApplicationController {
    static targets = ["activityArea"];
    static values = {
        inactivityTimeout: { type: Number, default: 10000 },
        hideCursorClass: { type: String, default: "cursor-hidden" }
    };

    connect() {
        this.startInactivityTimer();
        this.activityAreaTarget.addEventListener("mousemove", this.restartInactivityTimer);
        this.activityAreaTarget.addEventListener("keypress", this.restartInactivityTimer);
    }

    disconnect() {
        clearTimeout(this.inactivityTimer);
    }

    startInactivityTimer = () => {
        this.inactivityTimer = setTimeout(() => {
            this.hideCursor();
        }, this.inactivityTimeoutValue);
    };

    restartInactivityTimer = () => {
        clearTimeout(this.inactivityTimer);
        this.showCursor();
        this.startInactivityTimer();
    };

    hideCursor() {
        $("body").addClass(this.hideCursorClassValue);
    }

    showCursor() {
        $("body").removeClass(this.hideCursorClassValue);
    }
}
