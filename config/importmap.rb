pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Rails ActionCable
pin '@rails/actioncable', to: 'https://ga.jspm.io/npm:@rails/actioncable@7.0.0/app/assets/javascripts/actioncable.esm.js'

# Stimulus Reflex
pin 'stimulus_reflex', to: 'https://ga.jspm.io/npm:stimulus_reflex@3.5.0-pre8/javascript/stimulus_reflex.js'

# CableReady
pin 'cable_ready', to: 'https://ga.jspm.io/npm:cable_ready@5.0.0-pre8/javascript/index.js'

# Morphdom
pin 'morphdom', to: 'https://ga.jspm.io/npm:morphdom@2.6.1/dist/morphdom.js'

# Stimulus
pin 'stimulus', to: 'https://ga.jspm.io/npm:stimulus@3.0.1/dist/stimulus.js'

# Buffer
pin "buffer", to: "https://ga.jspm.io/npm:@jspm/core@2.0.0-beta.24/nodelibs/browser/buffer.js"

# jQuery and jQuery UI
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js"

pin "hotkeys-js", to: "https://ga.jspm.io/npm:hotkeys-js@3.10.2/dist/hotkeys.esm.js"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.51.3/dist/index.js"

pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/components", under: "components"
