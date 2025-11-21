import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['validDomainInfo', 'securityRole'];

  onSecurityRoleChanged() {
    let target = this.securityRoleTarget;
    let selectedOption = target.options[target.selectedIndex];

    let external = selectedOption.dataset.external == 'true';
    if(external) {
      this.validDomainInfoTarget.value;
    }

    if (external) {
      this.validDomainInfoTarget?.classList?.add('d-none');
    } else {
      this.validDomainInfoTarget?.classList?.remove('d-none');
    }
  }


  connect() {
    this.onSecurityRoleChanged();
  }
}
