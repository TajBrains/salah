// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"
import {cable} from "@hotwired/turbo-rails";
import StimulusReflex from "stimulus_reflex";

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
eagerLoadControllersFrom("components", application)

// initialize StimulusReflex w/top-level await
const consumer = await cable.getConsumer()
StimulusReflex.initialize(application, {consumer, debug: true});
