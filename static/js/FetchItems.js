const FetchItems = (type="All") => {
    // Api Call To Server And More Params like sort by...
    let fetchedObjs=[]
    for (let i = 0 ; i < 50; i++) {
        fetchedObjs.push({
            "image":`https://picsum.photos/300/200/?random=${i}`,
            "title": (makeid(Math.floor(Math.random() * 8) + 3)).toLocaleString(),
            "description":(makeid(Math.floor(Math.random() * 100) + 100)).toLocaleString(),
            "price": (Math.random()*10).toLocaleString()
        })
    }
    return fetchedObjs
}
function makeid(length) {
    let result           = '';
    let characters       = 'abcdefghijklmnopqrstuvwxyz';
    let charactersLength = characters.length;
    for ( let i = 0; i < length; i++ ) {
        result += characters.charAt(Math.floor(Math.random() *
            charactersLength));
        if (Math.random()>0.85) {
            result+=' ';
        }
    }
    return result.charAt(0).toUpperCase() + result.slice(1);
}
