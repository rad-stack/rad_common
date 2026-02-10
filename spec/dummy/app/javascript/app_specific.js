
import { Turbo } from '@hotwired/turbo-rails';
import * as bootstrap from 'bootstrap';
import { RadTomSelect } from 'rad_common/radTomSelect';

Turbo.StreamActions.hide_modal = function () {
  this.targetElements.forEach((target) => {
    const modal = bootstrap.Modal.getOrCreateInstance(target);
    modal.hide();
  });
};

document.addEventListener('turbo:frame-load', (event) => {
  const target_id = event.target.id;
  console.log('Turbo stream event target:', target_id);
  RadTomSelect.setup(target_id);
});
