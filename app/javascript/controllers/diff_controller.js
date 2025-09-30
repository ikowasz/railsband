import { Controller } from "@hotwired/stimulus"
import load_css from "utils/load_css"
import load_js from "utils/load_js";
import { FetchRequest } from "@rails/request.js"

// Connects to data-controller="diff"
export default class extends Controller {
  static targets = ["diffOutput", "textInput", "confirm"];
  static values = {
      prevVersionId: String,
      nextVersionId: String,
      songId: String,
      showUrl: String,
      nextVersionUrl: String,
      resolveUrl: String,
      isEditable: Boolean,
  };

  styles = [
      'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.8.0/styles/github.min.css',
      'https://cdn.jsdelivr.net/npm/diff2html/bundles/css/diff2html.min.css'
  ];
  scripts = [
      'https://cdn.jsdelivr.net/npm/diff2html/bundles/js/diff2html.min.js',
      'https://unpkg.com/turndown/dist/turndown.js',
  ];

  connect() {
      this.init();
  }

  async init() {
      this.styles.map((style) => load_css(style))
      await Promise.all(this.scripts.map((script) => load_js(script)));
      const diff = this.diffOutputTarget.innerHTML
      this.updateDiff(diff)
  }

  getDiffFiles() {
      const next = this.nextVersionIdValue ?? 'Your changes';
      const prev = this.prevVersionIdValue ?? 'Conflicting changes';

      return [prev, next];
  }

  updateDiff(diff) {
      const diffJson = Diff2Html.parse(diff)
      const diffFiles = this.getDiffFiles();
      const [oldName, newName] = diffFiles;
      diffJson[0] = { ...diffJson[0], oldName, newName }

      this.diffOutputTarget.innerHTML = Diff2Html.html(diffJson, {
          outputFormat: 'side-by-side',
          drawFileList: false,
          colorScheme: 'auto',
      })
  }

  async updateText(contents) {
      const data = {
          next_version_id: this.nextVersionIdValue,
          prev_version_id: this.prevVersionIdValue,
          text: contents,
      }
      const request = new FetchRequest('post', this.showUrlValue, {
          body: JSON.stringify(data),
          contentType: 'application/json',
          responseKind: 'json',
      })
      const response = await request.perform()
      if (response.ok) {
          const { diff } = await response.json;
          this.updateDiff(diff)
      }
  }

  async change() {
      const { value: contents } = this.textInputTarget
      return this.updateText(contents)
  }

  async confirm() {
      const contents = this.textInputTarget.value
      const data = { prev_version_id: this.prevVersionIdValue, next_version_id: this.nextVersionIdValue, text: contents };
      const request = new FetchRequest('post', this.resolveUrlValue, { body: JSON.stringify(data), redirect: false })
      const response = await request.perform()
      if (response.ok) {
          window.location.href = this.nextVersionUrlValue;
      }
  }
}
