import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'currentMessage',
    'form'
  ];

  connect() {
    const offcanvas = document.getElementById('mallow-question-modal');
    if (offcanvas) {
      offcanvas.addEventListener('shown.bs.offcanvas', () => {
        this.scrollChatContainer();
      }, { once: true });
    }
  }
  
  updateCurrentMessage(event) {
    this.currentMessageTarget.value = event.target.innerText;
    this.formTarget.requestSubmit();
  }

  scrollChatContainer() {
    const container = document.getElementById('scroll-container');
    container.scrollTop = container.scrollHeight;
  }
}
