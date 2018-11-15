import './main.css';
import { Elm } from './elm/Main.elm';
import CodeMirror from 'codemirror';
import CodeMirrorStyle from 'codemirror/lib/codemirror.css';
import CodeMirrorTheme from 'codemirror/theme/material.css';
import CodeMirrorMode from 'codemirror/mode/htmlmixed/htmlmixed';
import hljs from 'highlight.js/lib/highlight';
import xml from 'highlight.js/lib/languages/xml';
import 'highlight.js/styles/atom-one-light.css'


const node = document.getElementById('root');

const app = Elm.Main.init({ node: node });

app.ports.highlight.subscribe(function (classname) {
    setTimeout(() => {
        hljs.registerLanguage('xml', xml);
        hljs.initHighlighting();
    }, 50)
});

app.ports.setPreview.subscribe(function (code) {
    const node = document.getElementById('playground__preview');
    node.innerHTML = code;
})

customElements.define('code-editor', class extends HTMLElement {
    constructor() {
        super();
        this._editorValue = '';
    }

    get editorValue() {
        return this._editorValue;
    }

    set editorValue(value) {
        if (this._editorValue === value) return
        this._editorValue = value;
        if (!this._editor) return;
        this._editor.setValue(value);
    }

    connectedCallback() {
        this._editor = CodeMirror(this, {
            indentUnit: 4,
            mode: 'htmlmixed',
            lineNumbers: true,
            theme: 'material',
            value: this._editorValue
        })

        this._editor.on('changes', () => {
            this._editorValue = this._editor.getValue();
            this.dispatchEvent(new CustomEvent('editorChanged'))
        })
    }
})
