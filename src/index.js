import './assets/main.css';
import { Elm } from './elm/Main.elm';
import registerServiceWorker from './registerServiceWorker';
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

// document.onreadystatechange = () => {
//     if (document.readyState === 'interactive') {
//         const $playground = document.getElementById('playground__editor');
//         const codeMirror = CodeMirror.fromTextArea(
//             $playground,
//             {
//                 mode: 'htmlmixed',
//                 theme: 'material',
//                 lineNumbers: true
//             }
//         );
//         codeMirror.on('change', (cm, changes) => {
//             const node = document.getElementById('playground__preview');
//             node.innerHTML = codeMirror.getValue();
//         });

//     }
// };

registerServiceWorker();
