// flicker_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ["text"];

    get isHidden() {
        return $(this.element).hasClass("hidden")
    }
    connect() {
        this.flicker();
    }

    flicker() {
        $(this.textTarget).fadeToggle(800, () => {
            if (!this.isHidden) {
                this.flicker();
            }
        });
    }
}
