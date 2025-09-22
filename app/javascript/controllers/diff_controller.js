import { Controller } from "@hotwired/stimulus"
import load_css from "utils/load_css"
import load_js from "utils/load_js";
import { FetchRequest } from "@rails/request.js"

// Connects to data-controller="diff"
export default class extends Controller {
  static targets = ["diffOutput", "textInput", "confirm"];
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

  updateDiff(diff) {
      const diffJson = Diff2Html.parse(diff)
      diffJson[0].oldName = 'Your changes';
      diffJson[0].newName = 'Conflicting changes';

      this.diffOutputTarget.innerHTML = Diff2Html.html(diffJson, {
          outputFormat: 'side-by-side',
          drawFileList: false,
      })
  }

  async change() {
      const { value: contents, dataset } = this.textInputTarget
      const { diffUrl, diffId } = dataset
      const data = { id: diffId, text: contents }
      const request = new FetchRequest('post', diffUrl, { body: JSON.stringify(data) })
      const response = await request.perform()
      if (response.ok) {
          const json = await response.json;
          this.updateDiff(json.diff)
      }
  }

  async confirm() {
      const contents = this.textInputTarget.value
      const { diffId } = this.textInputTarget.dataset;
      const { diffResolveUrl, diffResolveId, diffSongId } = this.confirmTarget.dataset;
      const data = { id: diffId, conflictId: diffResolveId, text: contents }
      const request = new FetchRequest('post', diffResolveUrl, { body: JSON.stringify(data) })
      const response = await request.perform()
      if (response.ok) {
          window.location.href = '/songs/' + diffSongId
      }
  }
}
