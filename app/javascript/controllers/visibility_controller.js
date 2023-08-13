import ApplicationController from 'controllers/application_controller'

export default class extends ApplicationController {
    static values = {
        inactivityTimeout: { type: Number, default: 10000 },
        hideCursorClass: { type: String, default: "cursor-hidden" }
    };

    connect() {
        this.startInactivityTimer();
        $("body").on("mousemove keypress", this.restartInactivityTimer);
    }

    disconnect() {
        clearTimeout(this.inactivityTimer);
    }

    startInactivityTimer = () => {
        this.inactivityTimer = setTimeout(() => {
            this.hideElements();
        }, this.inactivityTimeoutValue);
    };

    restartInactivityTimer = () => {
        clearTimeout(this.inactivityTimer);
        this.showElements();
        this.startInactivityTimer();
    };

    hideElements() {
        $("body").addClass(this.hideCursorClassValue);
        $("footer").fadeOut(500);
    }

    showElements() {
        $("body").removeClass(this.hideCursorClassValue);
        $("footer").fadeIn(500);
    }
}
