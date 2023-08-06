import {Controller} from 'stimulus'

export default class extends Controller {
    dispatchReload() {
        Turbo.cache.clear();
        Turbo.visit(window.location.href, { action: 'replace' });
    }
}
