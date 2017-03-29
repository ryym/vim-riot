# vim-riot

[![License](http://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

This is a Vim plugin to provide syntax highlighting and indentation for
[Riot.js] custom tags. [Riot custom tag] contains HTML, CSS and JS in a single file.
The implementation of the indent file is based on [vim-jsx].

**Note that [pangloss/vim-javascript] is required** to use this plugin.  
(This javascript syntax plugin is included in Vim by default from [v7.4.2205](https://github.com/vim/vim/blob/v7.4.2205/runtime/indent/javascript.vim))

[Riot.js]: http://riotjs.com/
[Riot custom tag]: http://riotjs.com/guide
[pangloss/vim-javascript]: https://github.com/pangloss/vim-javascript
[vim-jsx]: https://github.com/mxw/vim-jsx 

## Installation

[NeoBundle](https://github.com/Shougo/neobundle.vim),
[Vundle](https://github.com/VundleVim/Vundle.vim),
[vim-plug](https://github.com/junegunn/vim-plug)

```vim
NeoBundle 'ryym/vim-riot'
Plugin 'ryym/vim-riot'
Plug 'ryym/vim-riot'
```

[pathogen](https://github.com/tpope/vim-pathogen)

```bash
cd ~/.vim/bundle
git clone https://github.com/ryym/vim-riot.git
```

## Sample Image

![syntax highlight sample](https://raw.githubusercontent.com/ryym/i/master/vim-riot/highlight-sample.png)
