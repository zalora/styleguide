import { Elm } from './elm/Main.elm';
import CodeMirror from 'codemirror';
import 'codemirror/lib/codemirror.css';
import 'codemirror/theme/eclipse.css';
import 'codemirror/mode/htmlmixed/htmlmixed';
import hljs from 'highlight.js/lib/highlight';
import xml from 'highlight.js/lib/languages/xml';
import 'highlight.js/styles/github-gist.css';
import '@zalora/style/dist/style.min.css';
import './main.css';


const node = document.getElementById('root');

const app = Elm.Main.init({ node: node });


customElements.define('code-snippet', class extends HTMLElement {
    constructor() {
        super();
        this._innerCode = '';
    }

    get innerCode() {
        return this._innerCode;
    }

    set innerCode(code) {
        if (this._innerCode === code) return
        this._innerCode = code;
    }

    connectedCallback() {
        hljs.registerLanguage('xml', xml);
        hljs.configure({
            useBR: true
          })
        const value = hljs.highlight("xml", this._innerCode).value;
        this.innerHTML = '<pre><code class="xlm hljs">' +hljs.fixMarkup(value)+ '</code></pre>';
    }
});

customElements.define('code-preview', class extends HTMLElement {
    constructor() {
        super();
        this._srcdoc = '';
    }

    get srcdoc() {
        return this._srcdoc;
    }

    set srcdoc(codestr) {
        if (this._srcdoc === codestr) return
        this._srcdoc = codestr;
    }

    connectedCallback() {
        this.innerHTML = this._srcdoc;
    }
});

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
            theme: 'eclipse',
            lineWrapping: true,
            value: this._editorValue
        })

        this._editor.on('changes', () => {
            this._editorValue = this._editor.getValue();
            const node = document.getElementById('playground__preview');
            node.innerHTML = this._editorValue;
            this.dispatchEvent(new CustomEvent('editorChanged'));
        })
    }
});


// For demo
window.showPopup = () => {
    document.getElementById('backdrop').style.display='flex';
    document.getElementById('popup').classList.remove('scale_down_center');
    document.getElementById('backdrop').classList.remove('fade_out');
    document.getElementById('popup').classList.add('scale_up_center');
    
}

window.hidePopup = () => {
    document.getElementById('popup').classList.remove('scale_up_center');
    document.getElementById('popup').classList.add('scale_down_center');
    document.getElementById('backdrop').classList.add('fade_out');
    setTimeout(()=>{document.getElementById('backdrop').style.display='none';}, 450);
}

window.togglePanel = ($el, id) => {
    if ($el.classList.contains('is-expanded')) {
        $el.classList.remove('is-expanded'); 
        document.getElementById(id).classList.remove('expand');
        document.getElementById(id).classList.add('collapse');
    } else {
        $el.classList.add('is-expanded'); 
        document.getElementById(id).classList.remove('collapse');
        document.getElementById(id).classList.add('expand');
    }
}
