import {Controller} from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
    connect() {
        StimulusReflex.register(this)
    }

    async safeStimulate(action, parameters) {
        const self = this
        return new Promise(async (resolve, reject) => {
            if (self.isActionCableConnectionOpen()) {
                resolve(await self.stimulate(action))
            } else {
                reject("closed_connection")
            }
        })
    }
}
