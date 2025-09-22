const load_js = (url) =>
    new Promise((resolve) => {
        const script = document.createElement('script')
        script.type = 'text/javascript';
        script.src = url;
        script.onload = resolve;
        document.head.appendChild(script)
    });

export default load_js