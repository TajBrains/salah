import ApplicationController from 'controllers/application_controller'

export default class extends ApplicationController {
    close_alert() {
        $(this.element).slideToggle(300, function() {
            $(this.element).remove()
        });
    }
}
