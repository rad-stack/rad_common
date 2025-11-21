import { Controller } from '@hotwired/stimulus';
import { EditorView, basicSetup } from 'codemirror';
import { javascript } from '@codemirror/lang-javascript'; // or another language

export default class extends Controller {
  static targets = ['configurationInput', 'reportForm'];
  connect() {
    this.setupEditor();
  }

  setupEditor() {
    // Create the CodeMirror editor
    const editor = new EditorView({
      doc: this.configurationInputTarget.value, // Initialize with textarea content
      extensions: [
        basicSetup,
        javascript(), // Change to your desired language
      ],
      parent: this.configurationInputTarget.parentNode,
    });

    // Hide the original textarea
    this.configurationInputTarget.style.display = 'none';

    // Sync editor content back to textarea
    const syncContent = () => {
      this.configurationInputTarget.value = editor.state.doc.toString();
    };

    // Sync on blur
    editor.dom.addEventListener('blur', syncContent);

    // Sync on form submission
    this.reportFormTarget.addEventListener('submit', syncContent);
  }
}
