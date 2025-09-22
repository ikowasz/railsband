const load_css = (url) => {
    const link = document.createElement('link')
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.href = url;

    return document.head.appendChild(link)
}
export default load_css