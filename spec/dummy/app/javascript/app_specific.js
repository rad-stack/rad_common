import { Turbo } from '@hotwired/turbo-rails';

Turbo.StreamActions.update_input = function () {
  this.targetElements.forEach((target) => {
    target.value = this.templateContent.textContent;
  });
};

Turbo.StreamActions.scroll_bottom = function () {
  this.targetElements.forEach((target) => {
    target.scrollTop = target.scrollHeight;
  });
};
