$ = {}
for $el in document.querySelectorAll('[id]')
    $[$el.id] = $el

module.exports = $

